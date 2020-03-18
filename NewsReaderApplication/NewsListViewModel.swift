//
//  NewsListViewModel.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct NewsListViewModel: NewsListViewBindable {
    
//    v -> vm
    var viewWillAppear: PublishRelay<Void>
    var willDisplayCell: PublishRelay<IndexPath>
    
//    vm -> v
    var cellData: Driver<[NewsItemDetail]>
    var reloadList: Signal<Void>
    var errorMessage: Signal<String>
    
    
    let responseParser: ResponseParser
    let htmlParser: HTMLParser

    init(responseParser: ResponseParser = ResponseParserImpl(), htmlParser: HTMLParser = HTMLParserImpl()) {
        
        self.responseParser = responseParser
        self.htmlParser = htmlParser
    }
    
    
    func process() {
        
        self.responseParser.startXMLParsing()
        let newsItems = self.responseParser.newsItems
        
        for i in newsItems {
            let url = URL(string: i.link)
            htmlParser.startHTMLParsing(linkURL: url!)
        }
        
        self.htmlParser.newsItemDetails
        
    }
    
}
