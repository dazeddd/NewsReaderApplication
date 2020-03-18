//
//  HTMLParser.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation
import SwiftSoup

//protocol HTMLParser {
//
//    var newsItemDetails: [NewsItemDetail] { get }
//
//    func startHTMLParsing(linkURL: URL)
//
//}



class HTMLParserImpl {
    
//    var newsItemDetails = [NewsItemDetail]()
    
    func startHTMLParsing(linkURL: URL) -> NewsItemDetail {
        
        
        do {
            // 에러문 다르게 해야 하는데..
            let linkHTMLString = try String(contentsOf: linkURL, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(linkHTMLString)
            
            let thumnailURL = try doc.select("head > meta[property='og:image']").attr("content")
            let mainTextPartial = try doc.select("head > meta[property='og:description']").attr("content")
       
            let newsItemDetail = NewsItemDetail(thumnailURL:thumnailURL , description: mainTextPartial)
            
            return newsItemDetail
                
            } catch {
                print("parsing error!!")
        }
        
        
        
    
            
            
    }
}
