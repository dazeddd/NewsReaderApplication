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
    var cellData: Driver<[NewsItem]>
    var reloadList: Signal<Void>
    var errorMessage: Signal<String>
    
    let responseParser: ResponseParser
    
    init(reponseParser: ResponseParser = ResponseParserImpl()) {
        
        let newsListResult = viewWillAppear
            .flatMapLatest(reponseParser.getParsedXML())
        
        
        
        
        self.cellData =
        
        self.reloadList =
        
    }
    
    
    
}
