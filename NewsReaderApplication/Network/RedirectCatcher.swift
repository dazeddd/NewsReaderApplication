//
//  CatchRedirect.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/25.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation

class RedirectCatcher: NSObject {
    
    var defaultSession: URLSession?
    var dataTask: URLSessionDataTask?
    var redirectedURL: URL!
    
    override init() {
        super.init()
        self.defaultSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    func request(url: URL) -> URL {
        
        dataTask?.cancel()
        dataTask = defaultSession?.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
//              print(error.localizedDescription)
                
            } else if let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 {
                
                
            }
        }
          
        // suspend 상태에서 -> resume
        // 비동기 처리 필요, 완료된 다음에 redirectedURL return 하게
        DispatchQueue.global().sync {
            dataTask?.resume()
        }
        
        
        
        return self.redirectedURL
    }
        
}

extension RedirectCatcher: URLSessionDelegate, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
        self.redirectedURL = request.url!
    }
    
}
