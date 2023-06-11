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
    
    func fetchMusic(completion: @escaping (Result<Music, NetworkError>) -> Void) {
        executeRequestFor(router: .home, completion: completion)
    }
    
}
