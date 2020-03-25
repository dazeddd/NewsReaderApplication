//
//  NewsReaderApplicationTests.swift
//  NewsReaderApplicationTests
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import XCTest
@testable import NewsReaderApplication

class NewsReaderApplicationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // nil 체크 XCTAssertNil, XCTAssertNotNil
    // String(contents0f: ) 리다이렉트된 url 의 html 가져올수있는지??
    
    func testHTMLParser() {
        
        
    }
    
    func testResponseParser() {
        
        
    }
    
    func testCellDataToDetailView() {
        //given
        
        
        //when
        
        
        //then
        let mainViewKeywordGroup: String
        let detailViewKeywordGroup: String
        
    }
    
    func testRedirectCatcher() {
        let redirectCatcher = RedirectCatcher2()

        let actualValue = redirectCatcher.loadWebView(url: URL(string: "https://news.google.com/__i/rss/rd/articles/CBMiOGh0dHA6Ly93d3cuaGFuaS5jby5rci9hcnRpL3BvbGl0aWNzL2Fzc2VtYmx5LzkzNDA3NC5odG1s0gEA?oc=5")!)

        let expectedValue = URL(string: "http://www.hani.co.kr/arti/politics/assembly/934074.html")!

        XCTAssertEqual(actualValue, expectedValue)


    }

}
