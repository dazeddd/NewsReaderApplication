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
    
    var detail: NewsItemDetail = NewsItemDetail(thumnailURL: "", description: "")
    var html: String = ""
    
    func startHTMLParsing(linkURL: URL) -> NewsItemDetail {
        
        
        do {
            // redirect 된 url 에서 html 가져와야 하는데..
            let linkHTMLString = try String(contentsOf: linkURL, encoding: .utf8)
            self.html = linkHTMLString
        } catch {
            print(error)
            return NewsItemDetail(thumnailURL: "", description: "")
        }
           
      
        do {
            let doc: Document = try SwiftSoup.parse(self.html)
            
            // thumanil URL 못가져오는 경우 "" 값 반환
            let thumnailURL = try doc.select("head > meta[property='og:image']").attr("content")
            let description = try doc.select("head > meta[property='og:description']").attr("content")
       
            let newsItemDetail = NewsItemDetail(thumnailURL:thumnailURL, description: description)
    
            self.detail = newsItemDetail
            
            } catch Exception.Error(let type, let message) {
                print(type)
                print(message)
            } catch {
                print("parsing not properly")
            }
    
        return detail
        
    }
}
