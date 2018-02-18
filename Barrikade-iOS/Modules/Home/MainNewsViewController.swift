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

final class MainNewsViewController: UIViewController, StoryboardBased {
    // Mark:- IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!

    // Mark:- Properties
    fileprivate var news = [News]()
    fileprivate var notificationToken: NotificationToken?

    // Mark:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load Data
        let newsResults = Realm.safeInstance().objects(News.self)
        news = newsResults.flatMap { $0 }

        notificationToken = newsResults.addNotificationBlock {[weak self] (changes: RealmCollectionChange) in
            self?.news = Realm.safeInstance().objects(News.self).flatMap { $0 }
            self?.tableView.reloadData()
        }
        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: NewsTableViewCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
}

// Mark:- UITableView Delegate & DataSource
extension MainNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HighlitedTVCHeader()
        header.fill(news: self.news)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 11/14 * self.view.bounds.width
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
