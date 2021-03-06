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
    
    func startAnalizing(sentence: String) -> String {
        
        var keywordList: [String: Int] = [:]
        var extractedWords: [String] = []
        var joinedString: String = ""
        
        if sentence == "" {
            return joinedString
        } else {
            let word_list = sentence.split(separator: " ")
            for word in word_list {
                let str = String(word)
                if keywordList[str] == nil {
                    keywordList[str] = 1
                } else {
                    if var count = keywordList[str] {
                        count += 1
                    }
                }
            }
            
            // 빈도수가 같을 경우 문자 오름차순으로
            let sortedDic = keywordList.sorted {
                if ($0.value > $1.value) {
                    return true
                } else if ($0.value == $1.value) {
                    if ($0.key < $1.key) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
            
            // 키워드 3개 이하로 뽑아내게
            guard sortedDic.count > 2 else {
                
                for element in sortedDic {
                    extractedWords.append(element.key)
                }
                joinedString = extractedWords.map({ "#" + $0 }).joined(separator: " ")
                return joinedString
            }
            
            for element in sortedDic[0...2] {
                extractedWords.append(element.key)
            }
            joinedString = extractedWords.map({ "#" + $0 }).joined(separator: " ")
            return joinedString
            
        }
        
    }
    
}


