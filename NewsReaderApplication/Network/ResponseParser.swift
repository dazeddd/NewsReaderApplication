//
//  rssParsing.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

//protocol ResponseParser {
//
//    var newsItems: [NewsItem] { get }
//
//    func getParsedXML() -> Result<[NewsItem],NewsError>
//}

enum NewsError: Error {
    
    case parsing
}



class ResponseParserImpl: NSObject, XMLParserDelegate {
    
    
    var currentElement = ""
    var newsItem: NewsItem!
    var newsItemDetail: NewsItemDetail!
    var newsItems: [NewsItem] = []
    var title: String = ""
    var link: String = ""
    
    var flag: Bool = false
    
    let htmlParser = HTMLParserImpl()
    
    // Observable 한 return 값을
    func getParsedXML(completion: @escaping (Result<[NewsItem],NewsError>) -> Void ) {
        
        let rssURL = URL(string: "https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko")
        
        // session.rx.data
        guard let parser = XMLParser(contentsOf: rssURL!) else {
            
            return
        }
        
        parser.delegate = self
        // parsing start
        parser.parse()
        
        completion(.success(newsItems))
        
    }
    
    
    
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if elementName == "item" {
            
            
        }
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "title" {
            
            self.title = string
        }
        else if currentElement == "link" {
            
            self.link = string
            
        }
        
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            
            
            let url = URL(string: self.link)
            newsItemDetail = htmlParser.startHTMLParsing(linkURL: url!)
            
            newsItem = NewsItem(title: self.title, link: self.link, newsDetail: self.newsItemDetail)
            newsItems.append(newsItem)
            
        }
    }
    
    // when finish parsing xml
    func parserDidEndDocument(_ parser: XMLParser) {
        
        
    }
    
    
    
    
}

//#article_body > div:nth-child(1) > div > img
//#YTN_Player > a > img:nth-child(2)
