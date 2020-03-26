//
//  NewsListViewController.swift
//  NewsReaderApplication
//
//  Created by 이준수 on 2020/03/17.
//  Copyright © 2020 LeeJoonsoo. All rights reserved.
//

import UIKit
import SnapKit


class NewsListViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    @IBOutlet weak var newsListView: UITableView!
    let newsListView = UITableView()
    let tableActivityIndicator = UIActivityIndicatorView()
    let refreshControl = UIRefreshControl()
    
    let responseParser = ResponseParserImpl()
    let sentenceAnalyzer = SentenceAnalyzer()
    
    var cellData: [NewsItem] = []
    var url: URL = URL(string: "https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko")!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(newsListView)
        view.addSubview(tableActivityIndicator)
        
        // Do any additional setup after loading the view.
        newsListView.register(NewsCustomCell.self, forCellReuseIdentifier: "newsCell")
        newsListView.frame = self.view.bounds
        
        
        tableActivityIndicator.style = .gray
        tableActivityIndicator.color = .black
        tableActivityIndicator.hidesWhenStopped = true
        tableActivityIndicator.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
        tableActivityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.cellData.isEmpty {
            responseParser.getParsedXML(url: url) { (result) in
                switch result {
                case .success(let result):
                    self.cellData = result
                case .failure(let error):
                    print(error)

                }
            }
        }
        
        newsListView.delegate = self
        newsListView.dataSource = self
        
        newsListView.refreshControl = self.refreshControl
        newsListView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        newsListView.refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        
    }
    
    
    @objc func refresh() {
        getData {
            self.newsListView.reloadData()
            DispatchQueue.main.async {
                self.newsListView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func getData(completion: @escaping () -> Void) {
        
        responseParser.getParsedXML(url: url) { (result) in
            switch result {
            case .success(let result):
                self.cellData = result
            case .failure(let error):
                print(error)
            }
        
        }
        completion()
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
        
        // 타이틀 텍스트
        cell.newsTitleLabel.text = cellData[indexPath.row].title
        
        // 뉴스 본문 일부
        cell.newsTextPiece.text = cellData[indexPath.row].newsDetail.description
        
        // 추출한 키워드
        let joinedKeyword = sentenceAnalyzer.startAnalizing(sentence: cellData[indexPath.row].newsDetail.description)
        cell.keywordGroup.text = joinedKeyword
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let newsDetailVC = NewsDetailViewController(item: cellData[indexPath.row])
        
        guard let navi = self.navigationController else {
            print("cannot find navigation controller")
            return
        }
        navi.pushViewController(newsDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tableActivityIndicator.stopAnimating()
    }
    
    
    
}
