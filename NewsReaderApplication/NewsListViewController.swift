//
//  NewsListViewController.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAppState


class NewsListViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    @IBOutlet weak var newsListView: UITableView!
    let newsListView = UITableView()
    let refershControl = UIRefreshControl()
    
    let responseParser = ResponseParserImpl()
    let sentenceAnalyzer = SentenceAnalyzer()
    
    
    var cellData: [NewsItem]!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(newsListView)
        
        responseParser.getParsedXML(completion: { (result) in
            switch result {
            case .success(let result):
                self.cellData = result
            case .failure(let error):
                print(error)
                
            }
        })

        // Do any additional setup after loading the view.
        newsListView.register(NewsCustomCell.self, forCellReuseIdentifier: "newsCell")
        newsListView.delegate = self
        newsListView.dataSource = self
        
        newsListView.frame = self.view.bounds
        newsListView.refreshControl = self.refershControl
        self.refershControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refershControl.attributedTitle = NSAttributedString(string: "업데이트 진행 중")
        
        
        
        
    }
    
    @objc func refresh() {
        
        getData {
            
            self.refershControl.endRefreshing()
        }
    }
    
    func getData(completion: @escaping () -> Void) {
        responseParser.getParsedXML(completion: { (result) in
            switch result {
            case .success(let result):
                self.cellData = result
            case .failure(let error):
                print(error)
                
            }
            completion()
        })
    }
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return cellData.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = newsListView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCustomCell
        
        
        // thumbnail 이미지 설정
        

        if let url = URL(string: cellData[indexPath.row].newsDetail.thumnailURL) {
            
            do {
                let imageData = try Data(contentsOf: url)
                cell.thumnailImageView.image = UIImage(data: imageData)
                
            } catch {
                print("cannot get imageData")
                
            }
        }
            
                
//        }
        
        // 타이틀 텍스트
        cell.newsTitleLabel.text = cellData[indexPath.row].title
        // 뉴스 본문 일부
        cell.newsTextPiece.text = cellData[indexPath.row].newsDetail.description
        
        
        // 버튼 스택 뷰에 버튼 subview 로 추가하기
        let keyword_list = sentenceAnalyzer.startAnalizing(sentence: cellData[indexPath.row].newsDetail.description)
        let joinedKeyword = keyword_list.joined(separator: "/")
        
        cell.keywordGroup.text = joinedKeyword
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigationController?.pushViewController(NewsDetailViewController(cellData: cellData[indexPath.row]), animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }

    
    

}
