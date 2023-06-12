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
    
    private let apiKey = "search?term=jack+johnson"
    
    var baseURL = "https://itunes.apple.com/"
    
    private var service: NetworkService
    
    init(service: NetworkService = NetworkManager()) {
        self.service = service
    }
}
extension API {
       
    func isConnectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
    
    func executeRequestFor<T:Decodable>(
        router: Router,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        if let urlRequest = prepareURlRequestFor(router: router, parameters: parameters, headers: headers, method: method) {
            service.execute(urlRequest: urlRequest, completion: completion)
        } else {
            completion(.failure(.invalidRequest))
        }
    }

    func prepareURlRequestFor(
        router : Router,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        
        let urlString = baseURL + router.path + "?api-key=" + apiKey
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)

        if let params = parameters {
            if method == .get || method == .delete {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                let queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                guard let newURL = urlComponents.url else {
                    return nil
                }
                request = URLRequest(url: newURL)
            } else {
                let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        }

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
