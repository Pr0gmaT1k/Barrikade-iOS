//
//  EventViewController.swift
//  Barrikade-iOS
//
//  Created by azerty on 09/03/2018.
//  Copyright © 2018 Pr0gmaT1k. All rights reserved.
//

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
    fileprivate var events = [Event]()
    fileprivate var highlitedNews = [Event]()
    fileprivate var notificationToken: NotificationToken?
    fileprivate let realm = Realm.safeInstance()
    public var id = 0
    public weak var delegate: EventViewControllerDelegate?

    // MARK:- Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Data
        let eventResults = realm.objects(Event.self)
        self.update(eventResults: eventResults)
        
        notificationToken = eventResults.addNotificationBlock {[weak self] (changes: RealmCollectionChange) in
            guard let eventResults = self?.realm.objects(Event.self) else { return }
            self?.update(eventResults: eventResults)
        }
        
        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: EventTableViewCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    // MARK:- Private func
    private func update(eventResults: Results<Event>) {
        if eventResults.count < 3 { return }
        self.tableView.isHidden = eventResults.isEmpty
        events = eventResults.sorted { $0.0.dateObject.compare($0.1.dateObject) == .orderedAscending }
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
