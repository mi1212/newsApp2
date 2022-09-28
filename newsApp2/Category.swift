//
//  Category.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 28.09.2022.
//

import Foundation

enum Category: String, CaseIterable {
    case allNews = "all news"
    case business = "business"
    case entertainment = "entertainment"
    case environment = "environment"
    case food = "food"
    case health = "health"
    case politics = "politics"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    case top = "top"
    case world = "world"
    
    static var CategoryArray: [String] {
        return Category.allCases.map { $0.rawValue }
      }
}
