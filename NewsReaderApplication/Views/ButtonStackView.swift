//
//  ButtonStackView.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import UIKit

class ButtonStackView: UIView {

    let buttonGroup = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonGroup.frame = self.bounds
        
        buttonGroup.axis = .horizontal
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

