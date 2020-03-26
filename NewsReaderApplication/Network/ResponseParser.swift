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
    
    
    let htmlParser = HTMLParserImpl()
    
    func getParsedXML(url: URL, completion: @escaping (Result<[NewsItem],NewsError>) -> Void ) {
        
        guard let parser = XMLParser(contentsOf: url) else {
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
            
            // news detail 이 온전한 경우에만 newsitems 리스트에 더해준다
            if (newsItemDetail.description == "" || newsItemDetail.thumnailURL == "") {
                return
            }
            newsItem = NewsItem(title: self.title, link: self.link, newsDetail: self.newsItemDetail)
            newsItems.append(newsItem)
        }
    }
   
}

