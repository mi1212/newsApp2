//
//  Countryes.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 28.09.2022.
//

import Foundation


enum Country: String, CaseIterable {
    case allCountries = "all"
    case ar = "Argentina"
    case au = "Australia"
    case at = "Austria"
    case be = "Belgium"
    case bz = "Belize"
    case br = "Brazil"
    case bg = "Bulgaria"
    case ca = "Canada"
    case cn = "China"
    case co = "Colombia"
    case cu = "Cuba"
    case cz = "Czechia"
    case eg = "Egypt"
    case fr = "France"
    case de = "Germany"
    case gr = "Greece"
    case hk = "Hong Kong"
    case hu = "Hungary"
    case id = "Indonesia"
    case ie = "Ireland"
    case il = "Israel"
    case it = "Italy"
    case jp = "Japan"
    case kr = "Korea (Republic of)"
    case lv = "Latvia"
    case lt = "Lithuania"
    case my = "Malaysia"
    case mx = "Mexico"
    case ma = "Morocco"
    case nl = "Netherlands"
    case nz = "New Zealand"
    case ng = "Nigeria"
    case no = "Norway"
    case ph = "Philippines"
    case pl = "Poland"
    case pt = "Portugal"
    case ro = "Romania"
    case ru = "Russian Federation"
    case sa = "Saudi Arabia"
    case rs = "Serbia"
    case sg = "Singapore"
    case sk = "Slovakia"
    case si = "Slovenia"
    case za = "South Africa"
    case se = "Sweden"
    case ch = "Switzerland"
    case tw = "Taiwan, Province of China[a]"
    case th = "Thailand"
    case tr = "Turkey"
    case ua = "Ukraine"
    case gb = "United Kingdom of Great Britain and Northern Ireland"
    case us = "United States of America"
    case ve = "Venezuela (Bolivarian Republic of)"
    
    var flag: String {
        let unicodeScalars = self.rawValue
            .unicodeScalars
            .map { $0.value + 0x1F1E6 - 65 }
            .compactMap(UnicodeScalar.init)
        var result = ""
        result.unicodeScalars.append(contentsOf: unicodeScalars)
        return result
    }
    
    static var countryesArray: [Country] {
        return Country.allCases.map { $0 }
      }
}
