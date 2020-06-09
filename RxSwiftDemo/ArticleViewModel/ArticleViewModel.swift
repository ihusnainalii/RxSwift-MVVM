//
//  ArticleViewModel.swift
//  RxSwiftDemo
//
//  Created by Kishan Suthar on 10/06/20.
//  Copyright © 2020 Kishan Suthar. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift



struct ArticleListViewModel {
    var articleViewModel : [ArticleViewModel]
}

extension ArticleListViewModel {
    
    init(articles: [Articles]) {
        self.articleViewModel = articles.compactMap(ArticleViewModel.init)
    }
}

struct ArticleViewModel {
    let articles: Articles
    init(_ articles: Articles) {
        self.articles = articles
    }
}

extension ArticleViewModel {
    var title : Observable<String> {
        return Observable<String>.just(articles.title ?? "")
    }
    
    var description : Observable<String> {
        return Observable<String>.just(articles.description ?? "")
    }
}

