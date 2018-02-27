//
//  HighlitedTVCHeader.swift
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
import Reusable

protocol HighlitedTVCHeaderDelegate: class {
    func HighlitedTVCHeaderDidSelectedNews(index: Int)
}

final class HighlitedTVCHeader: UIView, NibOwnerLoadable {
    // MARK:- IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    // Mark:- Properties
    weak var delegate: HighlitedTVCHeaderDelegate?
    fileprivate var previousOffSet: CGFloat = 0.0
    fileprivate var news = [News]() {
        didSet { self.collectionView.reloadData() }
    }

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
        delegate?.HighlitedTVCHeaderDidSelectedNews(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = self.collectionView.bounds.size.width - 80
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

    // TODO: This is dirty. Found a better way to do a nice swipe.
    private func pagingScrollStrap() {
        let offset = self.collectionView.contentOffset.x
        let direction = offset - previousOffSet
        let adapter: CGFloat = direction > 0 ? 0.55 : -0.45
        let nextPage = Int(round((offset / self.collectionView.frame.width) + adapter))
        // check if action is not out of bounds
        if nextPage >= news.count || nextPage < 0 { return }
        let index = IndexPath(row: nextPage, section: 0)
        self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}
