//
//  NewsDetailViewContoller.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController, WKUIDelegate {
    
    let titleLabel = UILabel()
    let keywordGroup = ButtonStackView()
    var orginalNewsView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        orginalNewsView = WKWebView(frame: .zero, configuration: webConfiguration)
        orginalNewsView.uiDelegate = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(keywordGroup)
        view.addSubview(orginalNewsView)
        
        let webViewURL = URL(string:)
        let webViewRequest = URLRequest(url: webViewURL)
        orginalNewsView.load(webViewRequest)
        
    }
    
}


