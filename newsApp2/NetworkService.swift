//
//  NetworkService.swift
//  newsApp2
//
//  Created by Mikhail Chuparnov on 12.09.2022.
//

import Foundation

class NetworkService {

    var page = 0
    
    //  построение запроса данных по URL
    
    func request(nextPage: Bool, completion: @escaping (Data?, Error?) -> Void) {
        let parametrs = self.requestWithoutParametrs(nextPage: nextPage)
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

    private func requestWithoutParametrs(nextPage: Bool) -> [String: String] {
        var parametrs = [String: String]()

        switch nextPage {
        case true:
            page += 1
            parametrs["page"] = String(page)
        case false:
            page = 0
            parametrs["page"] = String(page)
        }
        return parametrs
    }
    
    private func requestWithParametrs(nextPage: Bool, param: [String: String]) -> [String: String] {
        var parametrs = param

        switch nextPage {
        case true:
            page += 1
            parametrs["page"] = String(page)
        case false:
            page = 0
            parametrs["page"] = String(page)
        }
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
    
    func requestSourceNews(nextPage: Bool, param: [String:String],  completion: @escaping (Data?, Error?) -> Void) {
        var parametrs = self.requestWithParametrs(nextPage: nextPage, param: param)
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
