//
//  iTunesService.swift
//  
//
//  Created by Furkan Yükcü on 14.06.2023.
//

import Foundation
import Alamofire
public protocol iTunesServiceProtocol: AnyObject {
    func fetchMusic(searchWord: String, completion: @escaping (Result< [Music], Error >) -> Void)
}
public class iTunesService: iTunesServiceProtocol {
    public init () {}
    public func fetchMusic(searchWord: String, completion: @escaping (Result< [Music], Error >) ->Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchWord)&country=TR&entity=song"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(iTunesResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("********** JSON DECODE ERROR *******")
                }
            case .failure(let error):
                print("**** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription) ******")
            }
        }
    }
}
