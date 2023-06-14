//
//  API.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
enum Router {
    case home
    case arts
    case science

    var path: String {
        switch self {
        case .home:
            return "home.json"
        case .arts:
            return "arts.json"
        case .science:
            return "science.json"
        }
    }
}

final class API {
    
    static let shared: API = {
        let instance = API()
        return instance
    }()
    
    private let searchWord: String
    private var baseURL: String
    private var service: NetworkService
    
    init(service: NetworkService = NetworkManager(), searchWord: String = "") {
        self.searchWord = searchWord
        self.baseURL = ""
        self.service = service
        setupBaseURL(withSearchWord: searchWord)
    }
    
    func setupBaseURL(withSearchWord searchWord: String) {
          baseURL = "https://itunes.apple.com/search?term=\(searchWord)&country=tr&entity=song&attribute=mixTerm"
//        baseURL = "https://itunes.apple.com/search?term=\(searchWord)&country=TR&entity=song"
    }
  
}
extension API {
    
    func isConnectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
    
    func executeRequestFor<T: Decodable>(
        router: Router,
        searchWord: String,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        if var urlRequest = prepareURLRequestFor(router: router, searchWord: searchWord, parameters: parameters, headers: headers, method: method) {
            if method == .get || method == .delete {
                // Get veya delete metodu için query parametrelerini ekleyin
                if let params = parameters {
                    guard var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: true) else {
                        completion(.failure(.invalidRequest))
                        return
                    }
                    let queryItems = params.map {
                        URLQueryItem(name: $0.key, value: String(describing: $0.value))
                    }
                    urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                    urlRequest.url = urlComponents.url
                }
            } else {
                // Diğer metodlar için JSON verisini httpBody'ye ekleyin
                if let params = parameters {
                    let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    urlRequest.httpBody = jsonData
                }
            }
            
            service.execute(urlRequest: urlRequest, completion: completion)
        } else {
            completion(.failure(.invalidRequest))
        }
    }
    
    func prepareURLRequestFor(
        router: Router,
        searchWord: String,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        let urlString = baseURL.replacingOccurrences(of: "(searchWord)", with: searchWord) + router.path
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let requestHeaders = headers {
            for (field, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        
        return request
    }
}
