//
//  ServiceManager.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

protocol MusicServiceProtocol {
    
    func fetchMusic(completion: @escaping (Result<Music, NetworkError>) -> Void)
}

extension API: MusicServiceProtocol {
    
    public func fetchMusic(completion: @escaping (Result<Music, NetworkError>) -> Void) {
        let searchWord = "" // İstediğiniz arama kelimesini buraya yerleştirin
        executeRequestFor(router: .home, searchWord: searchWord, completion: completion)
    }
}
