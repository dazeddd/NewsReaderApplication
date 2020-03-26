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

    
    // nil 체크 XCTAssertNil, XCTAssertNotNil
    // String(contents0f: ) 리다이렉트된 url 의 html 가져올수있는지??
    
    func testParsingHTMLRightTags() {
        
        // given
        let htmlParser = HTMLParserImpl()
        let expectedDetail: NewsItemDetail = NewsItemDetail(
            thumnailURL: "http://flexible.img.hani.co.kr/flexible/normal/970/710/imgdb/original/2020/0325/20200325502013.jpg"
            , description: "이해찬 더불어민주당 대표가 25일 “더불어시민당의 승리가 곧 민주당의 승리”라며 4·15 총선에서 민주당의 사실상 비례위성정..."
        )
        
        // when
        let actualDetail: NewsItemDetail = htmlParser.startHTMLParsing(linkURL: URL(string:"http://www.hani.co.kr/arti/politics/assembly/934074.html")!)
        
        
        // then
        XCTAssertEqual(actualDetail.thumnailURL, expectedDetail.thumnailURL)
        XCTAssertEqual(actualDetail.description, expectedDetail.description)
        
        
    }
    
    func testKeywordExtractionLogic() {
        let analyzer = SentenceAnalyzer()
        let sentence = "깃헙 사이트 상에서 리드미를 작성할 수도 있지만 저는 로컬 디렉터리상에서 직접 작성하는 것을 선호합니다."
        
        let firstResult = analyzer.startAnalizing(sentence: sentence)
        let secondResult = analyzer.startAnalizing(sentence: sentence)
        
        XCTAssertEqual(firstResult, secondResult)
    }
    
    
    
    // parser performance test
    func testPerformanceResponseParser() {
        let parser = ResponseParserImpl()
        let url: URL = URL(string: "https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko")!
        
        parser.getParsedXML(url: url) { (result) in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                print(error)
                
            }
        }

    }
}
