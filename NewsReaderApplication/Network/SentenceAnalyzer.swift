//
//  SentenceAnalyzer.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import Foundation
import UIKit

class SentenceAnalyzer {
    
    func startAnalizing(sentence: String) -> [String] {
        
        var keywordList: [String] = []
        
//        sentence.split(separator: " ")
        
        keywordList.append(contentsOf: ["사과", "딸기", "바나나"])
        
        return keywordList
        
    }
    
    
}
