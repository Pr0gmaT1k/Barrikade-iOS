//
//  MainNewsViewController.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1K on 04/08/2017.
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

final class MainNewsViewController: UIViewController, StoryboardBased {
  // Mark:- IBOutlet
  @IBOutlet fileprivate weak var collectionView: UICollectionView!
  
  // Mark:- Properties
  fileprivate var highlitedNews = ["", "", ""]
  
  // Mark:- Public func
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // collectionView
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.register(cellType: HighlitedNewsCollectionViewCell.self)
  }
}

extension MainNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.highlitedNews.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(for: indexPath) as HighlitedNewsCollectionViewCell
    return cell
  }
}
