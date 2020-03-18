//
//  rssParsing.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation

protocol ResponseParser {
    
    var newsItems: [NewsItem] { get }
    
    func startXMLParsing()
}

class ResponseParserImpl: NSObject, XMLParserDelegate, ResponseParser {
    
    var currentElement = ""
    
    var newsItem = NewsItem(title: "", link: "")
    var newsItems = [NewsItem]()
    var title: String = ""
    var link: String = ""
    
    var flag: Bool = false
    
    func startXMLParsing() {
        
        let rssURL = URL(string: "https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko")
        guard let parser = XMLParser(contentsOf: rssURL!) else {
            return
        }
        
        parser.delegate = self
        // parsing start
        parser.parse()
        
        
        
    }
    
    
    
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if elementName == "item" {
            
            
        }
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "title" {
            
            title = string
        }
        else if currentElement == "link" {
            
            link = string
            
        }
        
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            newsItem = NewsItem(title: title, link: link)
            
            newsItems.append(newsItem)
        }
    }
    
    // when finish parsing xml
    func parserDidEndDocument(_ parser: XMLParser) {
        
        
    }
    
    
    
    
}

//#article_body > div:nth-child(1) > div > img
//#YTN_Player > a > img:nth-child(2)
