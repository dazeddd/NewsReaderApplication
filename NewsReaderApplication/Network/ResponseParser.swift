//
//  rssParsing.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation

enum NewsError: Error {
    case url
    case parsing
}


class ResponseParserImpl: NSObject, XMLParserDelegate {
    
    var currentElement = ""
    var newsItem: NewsItem = NewsItem(
        title: "", link: "", newsDetail: NewsItemDetail(thumnailURL: "", description: "")
    )
    var newsItemDetail: NewsItemDetail = NewsItemDetail(thumnailURL: "", description: "")
    var newsItems: [NewsItem] = []
    
    var title: String = ""
    var link: String = ""
    
//    var flag: Bool = false
    
    let htmlParser = HTMLParserImpl()
    
    func getParsedXML(completion: @escaping (Result<[NewsItem],NewsError>) -> Void ) {
        
        guard let rssURL = URL(string: "https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko") else {
            print("invalid rss url")
            completion(.failure(.url))
            return
        }
        
        guard let parser = XMLParser(contentsOf: rssURL) else {
            print("cannot get XML")
            completion(.failure(.parsing))
            return
        }
        
        parser.delegate = self
        parser.parse()
        completion(.success(newsItems))
    }
    
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
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
            self.newsItemDetail = htmlParser.startHTMLParsing(linkURL: url!)
            
            newsItem = NewsItem(title: self.title, link: self.link, newsDetail: self.newsItemDetail)
            newsItems.append(newsItem)
        }
    }
   
}

