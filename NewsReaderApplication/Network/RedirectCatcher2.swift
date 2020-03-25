//
//  RedirectCatcher2.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/25.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation
import WebKit

class RedirectCatcher2: NSObject {
    
    var redirectedURL: URL!
    
    func loadWebView(url: URL) -> URL {
        
        let webView = WKWebView()
        webView.navigationDelegate = self
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
        
        return self.redirectedURL
        
    }
    
}

extension RedirectCatcher2: WKNavigationDelegate {
    
    
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        self.redirectedURL = webView.url
    }
}
