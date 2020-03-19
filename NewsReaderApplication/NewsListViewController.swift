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

//protocol NewsListViewBindable {
//
////    View -> ViewModel
//    var viewWillAppear: PublishRelay<Void> { get }
//    var willDisplayCell: PublishRelay<IndexPath> { get }
//
//
////    ViewModel -> View
//    var cellData: Driver<[NewsItem]> { get }
//    var reloadList: Signal<Void> { get }
//    var errorMessage: Signal<String> { get }
//}



class NewsListViewController: UIViewController {
    
//    @IBOutlet weak var newsListView: UITableView!
    let newsListView = UITableView()
    
    var cellData: [NewsItem]
    
    
    
//    var disposeBag = DisposeBag()
    
    // RxSwift 로 binding 하면 datasource 필요 없음
//    func bind(_ viewModel: NewsListViewBindable) {
//
////        v -> vm
//        self.rx.viewWillAppear
//            .map{ _ in Void() }
//            .bind(to: viewModel.viewWillAppear)
//            .disposed(by: disposeBag)
//
//        newsListView.rx.willDisplayCell
//            .map{ $0.indexPath }
//            .bind(to: viewModel.willDisplayCell)
//            .disposed(by: disposeBag)
//
//
//
////        vm -> v
//        viewModel.cellData
//        .drive(newsListView.rx.items) { tv, row, data in
//            let index = IndexPath(row: row, section: 0)
//            let cell = tv.dequeueReusableCell(withIdentifier: String(describing: NewsCustomCell.self), for: index) as! NewsCustomCell
//
//            cell.setData(data: data)
//
//            return cell
//        }
//        .disposed(by: disposeBag)
//
//
//        viewModel.reloadList
//        .emit(onNext: { [weak self] _ in
//            self?.newsListView.reloadData()
//            })
//        .disposed(by: disposeBag)
//
//
//    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsListView.register(NewsCustomCell.self, forCellReuseIdentifier: "newsCell")
        
        let responseParser = ResponseParserImpl()
        
        
        
        responseParser.getParsedXML(completion: { (result) in
            switch result {
            case .success(let result):
                self.cellData = result
            case .failure(let error):
                print(error)
                
            }
        })
        
        
        
    }
    
    
    private func layout() {
        
        newsListView.frame = self.view.bounds
    }
 
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return cellData.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = newsListView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCustomCell
        
        do {
            let imageData = try Data(contentsOf: URL(string: cellData[indexPath.row].newsDetail.thumnailURL)!)
            cell.thumnailImageView.image = UIImage(data: imageData)
            
        } catch {
            
            
        }
        cell.newsTitleLabel.text = cellData[indexPath.row].title
        cell.newsTextPiece.text = cellData[indexPath.row].
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        
    }

    

}
