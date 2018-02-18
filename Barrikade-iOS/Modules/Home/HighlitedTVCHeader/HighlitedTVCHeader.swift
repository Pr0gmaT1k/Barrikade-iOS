//
//  HighlitedTVCHeader.swift
//  Barrikade-iOS
//
//  Created by Julien CLOUPET on 17/02/2018.
//  Copyright © 2018 Pr0gmaT1k. All rights reserved.
//

import UIKit
import Reusable

final class HighlitedTVCHeader: UIView, NibOwnerLoadable {
    // MARK:- IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    // Mark:- Properties
    fileprivate var news = [News]() {
        didSet { self.collectionView.reloadData() }
    }
    fileprivate var previousOffSet: CGFloat = 0.0

    // MARK:- INIT
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        HighlitedTVCHeader.loadFromNib(owner: self)

        // collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(cellType: HighlitedNewsCollectionViewCell.self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        HighlitedTVCHeader.loadFromNib(owner: self)
        // collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(cellType: HighlitedNewsCollectionViewCell.self)
    }

    // MARK:- fill
    func fill(news: [News]) {
        self.news = news
    }
}

// MARK:- UICollectionViewDataSource
extension HighlitedTVCHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(for: indexPath) as HighlitedNewsCollectionViewCell
        cell.fill(news: news[indexPath.row])
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension HighlitedTVCHeader: UICollectionViewDelegateFlowLayout {
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
