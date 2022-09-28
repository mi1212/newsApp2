//
//  SearchResult.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import Foundation

class SearchResults: Decodable {
    let status: String?
    let totalResults: Int?
    let results: [Result]?
    let code: String?
    let message: String?
}

struct Result: Decodable {
    let title: String?
    let link: String?
    let video_url: String?
    let description: String?
    let content: String?
    let pubDate: Date?
    let image_url: String?
    let source_id: String?
    let language: String?
}


