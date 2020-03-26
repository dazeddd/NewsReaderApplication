//
//  NewsDetailViewContoller.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class NewsDetailViewController: UIViewController, WKUIDelegate {
    
    var item: NewsItem!
    
    init(item: NewsItem) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let sentenceAnalyzer = SentenceAnalyzer()
    
    let titleLabel = UILabel()
    let keywordGroup = UILabel()
    let linkNewsView = WKWebView()
    
    let navigatingIndicator = UIActivityIndicatorView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        self.view.backgroundColor = .white
        
        
        // 타이틀
        titleLabel.text = self.item.title
        titleLabel.numberOfLines = 2
//        titleLabel.layer.borderColor = UIColor.red.cgColor
//        titleLabel.layer.borderWidth = 2.0
        titleLabel.backgroundColor = .white
        
        // 키워드 그룹

        let joinedKeyword = sentenceAnalyzer.startAnalizing(sentence: self.item.newsDetail.description)
        keywordGroup.text = joinedKeyword
//        keywordGroup.layer.borderColor = UIColor.red.cgColor
//        keywordGroup.layer.borderWidth = 2.0
        keywordGroup.backgroundColor = .white
        

        // 웹뷰
        guard let webViewURL = URL(string: self.item.link) else {
            print("invalid url!")
            return
        }
        let webViewRequest = URLRequest(url: webViewURL)
        linkNewsView.load(webViewRequest)
        linkNewsView.layer.borderColor = UIColor.gray.cgColor
        linkNewsView.layer.borderWidth = 2.0
        linkNewsView.navigationDelegate = self
        
        // 웹뷰 navigating indicator
        navigatingIndicator.startAnimating()
        navigatingIndicator.hidesWhenStopped = true
    }
    
    private func layout() {
        
        view.addSubview(titleLabel)
        view.addSubview(keywordGroup)
        view.addSubview(linkNewsView)
        view.addSubview(navigatingIndicator)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(160)
            make.left.equalTo(self.view).offset(50)
            make.right.equalTo(self.view).offset(-50)
            
        }
        
        keywordGroup.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(50)
            make.right.equalTo(self.view).offset(-50)
            
        }
        
        linkNewsView.snp.makeConstraints { (make) in
            make.top.equalTo(keywordGroup.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-50)
        }
        
        navigatingIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(linkNewsView.snp.centerY)
        }
        
    }
    
}

extension NewsDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        navigatingIndicator.stopAnimating()
    }
    
}
    




