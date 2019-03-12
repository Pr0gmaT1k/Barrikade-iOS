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
import RealmSwift

final class PageMenuViewController: UIViewController {
    // MARK:- IBoutlets
    @IBOutlet fileprivate weak var syncViewCSTR: NSLayoutConstraint!
    @IBOutlet fileprivate weak var syncLabel: UILabel!
    @IBOutlet fileprivate weak var pageContainer: UIView!
    

    // Mark:- Properties
    private let realm = Realm.safeInstance()
    private var pageMenu: CAPSPageMenu?
    private var controllerArray: [UIViewController] = []

    // Mark:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        // Page Menu
        // Setup VC
        self.title = L10n.navbarMainTitle

        let mainNewsVC = StoryboardScene.Main.newsViewController.instantiate()
        mainNewsVC.title = L10n.pageMenuAktuel
        mainNewsVC.id = 0
        mainNewsVC.delegate = self

        let localInfosVC = StoryboardScene.Main.newsViewController.instantiate()
        localInfosVC.title = L10n.pageMenuLocalInfos
        localInfosVC.id = 1
        localInfosVC.delegate = self
        
        let analyseVC = StoryboardScene.Main.newsViewController.instantiate()
        analyseVC.title = L10n.pageMenuAnalyses
        analyseVC.id = 2
        analyseVC.delegate = self
        
        let globaleInfosVC = StoryboardScene.Main.newsViewController.instantiate()
        globaleInfosVC.title = L10n.pageMenuGlobaleInfos
        globaleInfosVC.id = 3
        globaleInfosVC.delegate = self
        
//        let agendaVC = StoryboardScene.Main.eventViewController.instantiate()
//        agendaVC.title = L10n.pageMenuAgenda
//        agendaVC.delegate = self

        controllerArray.append(contentsOf: [mainNewsVC, localInfosVC, analyseVC, globaleInfosVC/*, agendaVC*/])

        // Page menu options
        let parameters: [CAPSPageMenuOption] = [
            .menuItemWidthBasedOnTitleTextWidth(true),
            .scrollMenuBackgroundColor(UIColor(named: .pageMenu)),
            .viewBackgroundColor(UIColor.groupTableViewBackground),
            .unselectedMenuItemLabelColor(.white),
            .selectionIndicatorHeight(1)
        ]

        // Init and add menu
        let frame = self.pageContainer.bounds
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height), pageMenuOptions: parameters)
        guard let pageMenu = pageMenu else { return }
        self.pageContainer.addSubview(pageMenu.view)
        
        // Sync Bar
        Synchronizer.syncObserver = { [weak self] isSyncing in
            if let totNewsInBase = self?.realm.objects(News.self).count,
                let totRemoteNews = Synchronizer.totalRemoteEntries {
                let nbNewsToSync = (totRemoteNews - totNewsInBase).description
                self?.syncLabel.text = L10n.syncMessageArticleToSync + nbNewsToSync
            }
            self?.syncViewCSTR.constant = isSyncing ? 30 : 0
            self?.syncLabel.isHidden = isSyncing ? false : true
        }
    }
}

// MARK:- NewsViewControllerDelegate
extension PageMenuViewController: NewsViewControllerDelegate {
    func newsVCPresentNews(news: News) {
        let vc = StoryboardScene.Main.detailsNewsViewController.instantiate()
        vc.news = news
        self.present(vc, animated: true)
    }
}

// MARK:- EventViewControllerDelegate
extension PageMenuViewController: EventViewControllerDelegate {
    func eventVCPresentNews(event: Event) {
        let vc = StoryboardScene.Main.eventDetailsViewController.instantiate()
        vc.event = event
        self.present(vc, animated: true)
    }
}
