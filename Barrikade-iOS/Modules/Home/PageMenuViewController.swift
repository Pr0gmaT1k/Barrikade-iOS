//
//  ViewController.swift
//  Barrikade-iOS
//
//  Created by Pr0gmaT1k on 02/01/2018.
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
import PageMenu
import Reusable

final class PageMenuViewController: UIViewController {
  
  // Mark:- Properties
  private var pageMenu: CAPSPageMenu?
  private var controllerArray: [UIViewController] = []
  
  // Mark:- Public func
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = L10n.navbarMainTitle
    
    let mainNewsVC = StoryboardScene.Main.mainNewsViewController.instantiate()
    mainNewsVC.title = L10n.pageMenuAktuel
    
    let localInfosVC = StoryboardScene.Main.newsViewController.instantiate()
    localInfosVC.title = L10n.pageMenuLocalInfos
    localInfosVC.view.backgroundColor = UIColor.yellow
    
    let analyseVC = StoryboardScene.Main.newsViewController.instantiate()
    analyseVC.title = L10n.pageMenuAnalyses
    analyseVC.view.backgroundColor = UIColor.green
    
    let globaleInfosVC = StoryboardScene.Main.newsViewController.instantiate()
    globaleInfosVC.title = L10n.pageMenuGlobaleInfos
    globaleInfosVC.view.backgroundColor = UIColor.red
    
    let agendaVC = StoryboardScene.Main.newsViewController.instantiate()
    agendaVC.title = L10n.pageMenuAgenda
    agendaVC.view.backgroundColor = UIColor.blue
    
    controllerArray.append(contentsOf: [mainNewsVC, localInfosVC, analyseVC, globaleInfosVC, agendaVC])
    
    // Page menu options
    let parameters: [CAPSPageMenuOption] = [
      .menuItemWidthBasedOnTitleTextWidth(true),
      .scrollMenuBackgroundColor(UIColor(named: .pageMenu)),
      .viewBackgroundColor(UIColor(named: .pageMenu)),
      .unselectedMenuItemLabelColor(.white),
      .selectionIndicatorHeight(1)
    ]
    
    // Init and add menu
    let frame = self.view.bounds
    pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height), pageMenuOptions: parameters)
    guard let pageMenu = pageMenu else { return }
    self.view.addSubview(pageMenu.view)
  }
}
