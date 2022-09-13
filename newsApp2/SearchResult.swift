//
//  SearchResult.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import Foundation

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
    let description: String?
    let pubDate: Date?
    let image_url: String?
    let language: String?
}


//class SourcesRequest: Decodable {
//    let status: String
//    let sources: [Source]?
//    let message: String?
//}
//
//struct Source: Decodable {
//    let id: String?
//    let name: String?
//    
//    
//    let description: String?
//    let url: String?
//    let category: String?
//    let language: String?
//    let country: String?
//}
