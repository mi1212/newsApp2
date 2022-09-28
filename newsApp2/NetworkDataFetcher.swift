//
//  NetworkDataFetcher.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    // запрос новостей
    
    func fetchNews (completion: @escaping (SearchResults?) -> ()) {
        networkService.request() { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription )")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            
            
            completion(decode)
        }
    }
    
    func fetchSourceNews (id: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.requestSourceNews(id, nil) { (data, error) in
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription )")
                completion(nil)
            }
                        
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            
        
            completion(decode)
        }
    }
    
    func fetchCountryNews (country: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.requestSourceNews(nil, country) { (data, error) in
            
            print("fetchCountryNews")
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription )")
                completion(nil)
            }
                        
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            
        
            completion(decode)
        }
    }
    
    // парсинг
    
    func decodeJSON<T: Decodable> (type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = formatter.date(from: dateString) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Cannot decode date string \(dateString)")
        }
        
        guard let data = from else { return nil }
        
        
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
