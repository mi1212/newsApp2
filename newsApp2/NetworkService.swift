//
//  NetworkService.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import Foundation

class NetworkService {

    var page = 1
    
    //  построение запроса данных по URL
    
    func request(completion: @escaping (Data?, Error?) -> Void) {
        let parametrs = self.requestParametrs()
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        print(request.description)
        task.resume()
    }
    
    // параметры хэдера
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["X-ACCESS-KEY"] = "pub_11064589d1a11a44e5ff61027c6a6524ea13c"
        return headers
    }
    
    // параметры запроса

    private func requestParametrs() -> [String: String] {
        var parametrs = [String: String]()
        parametrs["country"] = "us"
        parametrs["page"] = String(page)
//        page += 1
        return parametrs
    }
    
    // параметры адреса
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsdata.io"
        components.path = "/api/1/news"
        components.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    //
    
    func requestSourceNews(_ id: String, completion: @escaping (Data?, Error?) -> Void) {
        var parametrs = self.requestParametrs()
        parametrs["category"] = id
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        print(request.description)
        task.resume()
    }

private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            completion(data, error)
        }
    }
}
}
