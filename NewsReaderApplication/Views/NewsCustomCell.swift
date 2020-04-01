//
//  NewsCustomCell.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.

import UIKit
import SnapKit

class NewsCustomCell: UITableViewCell {
    
    let thumnailImageView = UIImageView()
    let newsTitleLabel  = UILabel()
    let newsTextPiece = UILabel()
    let keywordGroup = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumnailImageView.image = UIImage(named: "noimage")
        
//        newsTitleLabel.adjustsFontSizeToFitWidth = true
        newsTitleLabel.textAlignment = .left
        newsTitleLabel.font = UIFont.systemFont(ofSize: 13)
        
        newsTextPiece.font = UIFont.systemFont(ofSize: 13)
        newsTextPiece.numberOfLines = 2
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    private func layout() {
        
        [thumnailImageView, newsTitleLabel, newsTextPiece, keywordGroup]
            .forEach { self.addSubview($0) }
        
        thumnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.left.equalTo(self).offset(20)
            
            make.width.height.equalTo(110)
        }
        newsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumnailImageView.snp.right).offset(20)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-10)
        }
        newsTextPiece.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(20)
            make.left.equalTo(thumnailImageView.snp.right).offset(20)
            make.right.equalTo(self).offset(-10)
        }
        keywordGroup.snp.makeConstraints { (make) in
            make.top.equalTo(newsTextPiece.snp.bottom).offset(20)
            make.left.equalTo(thumnailImageView.snp.right).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.right.equalTo(self).offset(-10)
        }
            
    }

}
