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
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var tableView: UITableView!

    // Mark:- Properties
    fileprivate var highlitedNews = ["", "", ""]
    fileprivate var news = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    fileprivate var previousOffSet: CGFloat = 0.0
    private let barrikadeWSClient =  BarrikadeWSClient()
    private let disposeBag = DisposeBag()

    // Mark:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()

        // collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(cellType: HighlitedNewsCollectionViewCell.self)

        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: NewsTableViewCell.self)
        self.tableView.rowHeight = 150

        barrikadeWSClient.getNews(startAt: 0)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed: break
                case .next: break
                case .error(let error): print(error.localizedDescription)
                }
            }.addDisposableTo(disposeBag)
    }
}


// Mark:- UICollectionViewDataSource
extension MainNewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.highlitedNews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(for: indexPath) as HighlitedNewsCollectionViewCell
        return cell
    }
}

// Mark:- UICollectionViewDelegateFlowLayout
extension MainNewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = self.collectionView.bounds.size.width - 30
        return CGSize(width: cellwidth, height: cellwidth  * 5 / 6)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.pagingScrollStrap()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.pagingScrollStrap()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.previousOffSet = self.collectionView.contentOffset.x
    }

    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        // load news
    }

    // TODO: This is dirty. Found a better way to do a nice swipe.
    private func pagingScrollStrap() {
        let offset = self.collectionView.contentOffset.x
        let direction = offset - previousOffSet
        let adapter: CGFloat = direction > 0 ? 0.55 : -0.45
        let nextPage = round((offset / self.collectionView.frame.width) + adapter)
        let index = IndexPath(row: Int(nextPage), section: 0)
        self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

// Mark:- UITableView Delegate & DataSource
extension MainNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as NewsTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Load news
    }
}
