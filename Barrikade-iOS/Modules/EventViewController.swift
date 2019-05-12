//
//  EventViewController.swift
//  Barrikade-iOS
//
//  Created by azerty on 09/03/2018.
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

protocol EventViewControllerDelegate: class {
    func eventVCPresentNews(event: Event)
}

final class EventViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK:- Properties
    fileprivate var events = [Event]()
    fileprivate var highlitedNews = [Event]()
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
    public var id = 0
    public weak var delegate: EventViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Data
        let eventResults = realm.objects(Event.self)
        self.update(eventResults: eventResults)
        
        notificationToken = eventResults.observe {[weak self] (changes: RealmCollectionChange) in
            guard let eventResults = self?.realm.objects(Event.self) else { return }
            self?.update(eventResults: eventResults)
        }
        
        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: EventTableViewCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    // MARK:- Private func
    private func update(eventResults: Results<Event>) {
        if eventResults.count < 3 { return }
        self.tableView.isHidden = eventResults.isEmpty
        events = eventResults.sorted { $0.dateObject.compare($1.dateObject) == .orderedAscending }
        self.tableView.reloadData()
    }
}

// MARK:- UITableViewDelegate / DataSource
extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as EventTableViewCell
        cell.fill(event: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.eventVCPresentNews(event: events[indexPath.row])
    }
}
