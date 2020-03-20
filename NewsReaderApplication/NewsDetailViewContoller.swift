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
    
    var cellData: NewsItem!
    
    
    init(cellData: NewsItem) {
        super.init(nibName: nil, bundle: nil)
        self.cellData = cellData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let sentenceAnalyzer = SentenceAnalyzer()
    
    let titleLabel = UILabel()
    let keywordGroup = UILabel()
    var linkNewsView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        linkNewsView = WKWebView(frame: .zero, configuration: webConfiguration)
        linkNewsView.uiDelegate = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        // 타이틀
        titleLabel.text = cellData.title
        
        // 키워드 그룹
//        keywordGroup.axis = .horizontal
//        keywordGroup.alignment = .fill
//        keywordGroup.distribution = .fillProportionally
//        keywordGroup.spacing = 3
//        keywordGroup.translatesAutoresizingMaskIntoConstraints = false
        
        let keyword_list = sentenceAnalyzer.startAnalizing(sentence: cellData.newsDetail.description)
        let joinedKeyword = keyword_list.joined(separator: "/")
        keywordGroup.text = joinedKeyword
        
        // 웹뷰에 뉴스 원문이 보이게 해야 하는뎁
        let webViewURL = URL(string: cellData.link)
        let webViewRequest = URLRequest(url: webViewURL!)
        linkNewsView.load(webViewRequest)
        
        
        
    }
    
    private func layout() {
        
        view.addSubview(titleLabel)
        view.addSubview(keywordGroup)
        view.addSubview(linkNewsView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(50)
            make.left.equalTo(self.view).offset(70)
            make.right.equalTo(self.view).offset(70)
            
        }
        
        keywordGroup.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(70)
            make.right.equalTo(self.view).offset(70)
            
        }
        
        linkNewsView.snp.makeConstraints { (make) in
            make.top.equalTo(keywordGroup.snp.bottom).offset(50)
            make.left.equalTo(self.view).offset(70)
            make.right.equalTo(self.view).offset(70)
            make.bottom.equalTo(self.view).offset(20)
        }
        
        
        
        
        
    }
    
}


