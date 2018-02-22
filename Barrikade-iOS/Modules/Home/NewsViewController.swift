//
//  MainNewsViewController.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1K on 02/01/2018.
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
import Reusable
import RxSwift
import RealmSwift

final class NewsViewController: UIViewController, StoryboardBased {
    // MARK:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var syncViewCSTR: NSLayoutConstraint!
    @IBOutlet fileprivate weak var syncLabel: UILabel!
    
    // MARK:- Properties
    fileprivate var news = [News]()
    fileprivate var highlitedNews = [News]()
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load Data
        let newsResults = realm.objects(News.self)
        self.update(newsResults: newsResults)
        
        notificationToken = newsResults.addNotificationBlock {[weak self] (changes: RealmCollectionChange) in
            guard let newsResults = self?.realm.objects(News.self) else { return }
            self?.update(newsResults: newsResults)
        }
        
        Synchronizer.syncObserver = { [weak self] isSyncing in
            if let totNewsInBase = self?.realm.objects(News.self).count,
                let totRemoteNews = Synchronizer.totalRemoteEntries {
                let nbNewsToSync = (totRemoteNews - totNewsInBase).description
                self?.syncLabel.text = L10n.syncMessageArticleToSync + nbNewsToSync
            }
            self?.syncViewCSTR.constant = isSyncing ? 30 : 0
            self?.syncLabel.isHidden = isSyncing ? false : true
        }
        
        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: NewsTableViewCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    private func update(newsResults: Results<News>) {
        if newsResults.count < 2 { return }
        let orderedNews = newsResults.sorted { $0.0.dateObject.compare($0.1.dateObject) == .orderedDescending }
        news = orderedNews[2...orderedNews.endIndex - 1].flatMap { $0 }
        highlitedNews = orderedNews[orderedNews.startIndex...1].flatMap { $0 }
        self.tableView.reloadData()
    }
}

// MARK:- UITableView Delegate & DataSource
extension MainNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HighlitedTVCHeader()
        header.fill(news: self.highlitedNews)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9/14 * self.view.bounds.width
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as NewsTableViewCell
        cell.fill(news: news[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Load news
    }
}
