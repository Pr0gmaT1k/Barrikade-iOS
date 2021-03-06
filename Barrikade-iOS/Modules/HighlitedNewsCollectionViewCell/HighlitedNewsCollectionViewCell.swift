//
//  HighlitedNewsCollectionViewCell.swift
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

final class HighlitedNewsCollectionViewCell: UICollectionViewCell, NibReusable {
    // Mark:- IBOutlet
    @IBOutlet private weak var countainerView: UIView!
    @IBOutlet private weak var imageNews: UIImageView!
    @IBOutlet private weak var titleNews: UILabel!
    @IBOutlet private weak var subtitleNews: UILabel!

    // Mark:- func
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countainerView.layer.shadowOpacity = 0.2
    }

    public func fill(news: News) {
        self.titleNews.text = news.title
        self.subtitleNews.text = news.chapo?.removeBarrikadeSpecific
        guard let urlString = news.logo, let url = URL(string: urlString) else { return }
        self.imageNews.kf.setImage(with: url)
    }
}
