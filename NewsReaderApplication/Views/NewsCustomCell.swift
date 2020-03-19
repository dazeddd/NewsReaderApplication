//
//  NewsCustomCell.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import UIKit

class NewsCustomCell: UITableViewCell {
    
    let thumnailImageView = UIImageView()
    let newsTitleLabel  = UILabel()
    let newsTextPiece = UILabel()
    let keywordGroup = ButtonStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func layout() {
        
        [thumnailImageView, newsTitleLabel, newsTextPiece, keywordGroup]
            .forEach { self.addSubview($0) }
        
//        나중에
        
        
    }
    
    
//    func setData(data: NewsItem) {
//
//        do {
//            let imageData = try Data(contentsOf: URL(string: data.newsDetail.thumnailURL)!)
//            thumnailImageView.image = UIImage(data: imageData)
//        } catch {
//            print("cannot set thumnail image!!!")
//        }
//
//        newsTitleLabel.text = data.title
//        // 라벨에 맞게 길이 조절해야 하는데..
//        newsTextPiece.text = data.newsDetail.description
//        keywordGroup.buttonGroup.addA
//
//    }

}
