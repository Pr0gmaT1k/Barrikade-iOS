//
//  Synchronizer.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1K on 18/01/2018.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit
import RealmSwift
import RxSwift

/** For now, Synchronizer synchronize  */
struct Synchronizer {
    // MARK:- Private properties
    private let barrikadeWSClient =  BarrikadeWSClient()
    private let disposeBag = DisposeBag()
    private let realm = Realm.safeInstance()
    private static var isSyncing: Bool = false { didSet { Synchronizer.syncObserver?(isSyncing) } }
    
    // MARK:- Public Properties
    public static var syncObserver: ((Bool) -> Void)? { didSet { Synchronizer.syncObserver?(Synchronizer.isSyncing) } }
    public static var totalRemoteEntries: Int64?
    
    
    
    // Mark:- Public func
    /**
     Sync everything from the newest to oldest
     Basically synchronize news and event
     */
    public func sync() {
        syncNews()
        syncEvent()
    }
    
    /**
     :func: syncNews Synchronize the database of Barrikade news. Stop when we get a news that is already in the database.
     :startAt: Custom pagination start. Default value = 0
     */
    func syncNews(startAt: Int = 0) {
        Synchronizer.isSyncing = true
        
        barrikadeWSClient.getNews(startAt: startAt)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed: break
                case .next(let articleCollection):
                    // Check nullable value
                    guard let totalEntries = articleCollection?.pagination?.totalEntries.value,
                        let data = articleCollection?.data,
                        let id = data.last?.id else { return }
                    
                    Synchronizer.totalRemoteEntries = totalEntries
                    // Check if one of the oldest fetched news is in the DB.
                    if self.realm.object(ofType: News.self, forPrimaryKey: id) == nil
                        && startAt < totalEntries {
                        // Add all then reccursive
                        try? self.realm.write {
                            self.realm.add(data)
                        }
                        self.syncNews(startAt: startAt + 10)
                    } else {
                        // Add one by one then stop sync
                        for news in data {
                            if self.realm.object(ofType: News.self, forPrimaryKey: news.id) == nil {
                                try? self.realm.write {
                                    self.realm.add(news)
                                }
                            }
                        }
                        Synchronizer.isSyncing = false
                    }
                case .error(let error):
                    print(error)
                    Synchronizer.isSyncing = false
                }
            }.disposed(by: disposeBag)
    }
    
    /**
     :func: syncEvent Synchronize the database of Barrikade event. Stop when we get a event that is already in the database.
     :startAt: Custom pagination start. Default value = 0
     */
    public func syncEvent(startAt: Int = 0) {
        barrikadeWSClient.getEvent(startAt: startAt)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed: break
                case .error(let error): print(error)
                case .next(let eventCollection):
                    // Check nullable value
                    guard let totalEntries = eventCollection?.pagination?.totalEntries.value,
                        let data = eventCollection?.data,
                        let id = data.last?.id else { return }
                    
                    // Check if one of the oldest fetched event is in the DB.
                    if self.realm.object(ofType: Event.self, forPrimaryKey: id) == nil
                        && startAt < totalEntries {
                        // Add all then reccursive
                        try? self.realm.write {
                            self.realm.add(data)
                        }
                        self.syncEvent(startAt: startAt + 10)
                    } else {
                        // Add one by one then stop sync
                        for event in data {
                            if self.realm.object(ofType: Event.self, forPrimaryKey: event.id) == nil {
                                try? self.realm.write {
                                    self.realm.add(event)
                                }
                            }
                        }
                    }
                }
            }.disposed(by: disposeBag)
    }
}
