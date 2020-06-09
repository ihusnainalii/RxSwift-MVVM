//
//  StatusViewcontroller.swift
//  RxSwiftDemo
//
//  Created by Kishan Suthar on 09/06/20.
//  Copyright © 2020 Kishan Suthar. All rights reserved.
//

import UIKit
import RxSwift

class StatusViewcontroller: UIViewController {
    
    // MARK: declare outlet and variable
    let disposable =  DisposeBag()
    private var articleVM: ArticleListViewModel!
    
    @IBOutlet weak var tblStatus: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callNewsAPI()
    }
    
    
    // MARK: method for get news data
    func callNewsAPI() {
        
        let resource = Resource<ArticlesResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=d47593762cf74491a9c81df5c87a8f8e"))
        URLRequest.load(resource: resource)
            .subscribe(onNext: { (arr) in
                let article = arr.articles
                self.articleVM = ArticleListViewModel(articles: article)
                DispatchQueue.main.async {
                    self.tblStatus.reloadData()
                }
            })
    }
}

// MARK: set tableview datasource and delegate
extension StatusViewcontroller : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleVM == nil ? 0 : self.articleVM.articleViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblStatus.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let articlesVM = self.articleVM.articleViewModel[indexPath.row]
        articlesVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.lblTitle.rx.text)
            .disposed(by: disposable)
        
        articlesVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.lblDescription.rx.text)
            .disposed(by: disposable)
        
        return cell
    }
}
