//
//  articles.swift
//  RxSwiftDemo
//
//  Created by Kishan Suthar on 10/06/20.
//  Copyright © 2020 Kishan Suthar. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


struct ArticlesResponse: Decodable {
    var articles: [Articles]
}

struct Articles : Decodable {
    var title : String?
    var description: String?
}
