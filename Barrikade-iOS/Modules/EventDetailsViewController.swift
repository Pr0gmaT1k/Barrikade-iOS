//
//  EventDetailsViewController.swift
//  Barrikade-iOS
//
//  Created by azerty on 16/03/2018.
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

final class EventDetailsViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet fileprivate weak var webView: UIWebView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    // MARK:- Properties
    var event: Event?
    fileprivate var stringCSS = String()
    
    // MARK:- Public func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let articleHTML = self.event?.descriptionn else { return }
        
        // Web View
        let htmlHeadCSS = L10n.newsDetailsHtml(articleHTML)
        self.webView.loadHTMLString(htmlHeadCSS, baseURL: Bundle.main.bundleURL)
        
        // Title
        self.titleLabel.text = event?.title
    }
    
    // MARK:- IBActions
    @IBAction func dismissDidTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareDidTouch(_ sender: Any) {
        guard let eventLink = event?.selff else { return }
        let vc = UIActivityViewController(activityItems: [eventLink], applicationActivities: nil)
        self.present(vc, animated: true)
    }
}
