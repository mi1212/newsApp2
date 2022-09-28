//
//  Language.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 28.09.2022.
//

import Foundation

enum Language: String, CaseIterable {
    case allNews = "all language"
    case ar = "Arabic"
    case de = "German"
    case en = "English"
    case es = "Estonian"
    case fr = "French"
    case he = "Hebrew"
    case it = "Italian"
    case nl = "Dutch"
    case no = "Norwegian"
    case pt = "Portuguese"
    case ru = "Russian"
    case sv = "Spanish"
    case zh = "Chinese"

    static var languagesArray: [String] {
        return Language.allCases.map { $0.rawValue }
      }
}
