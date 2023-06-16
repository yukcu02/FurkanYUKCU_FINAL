//
//  HomeInteractor.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation
import iTunesAPI

typealias MusicSourcesResult = Result<MusicData, NetworkError>

protocol HomeInteractorProtocol: AnyObject {
    func fetchMusic(_ searchWord: String)
}

protocol HomeInteractorOutputProtocol {
    func fetchMusicOutput(_ result: [Music])
}

//fileprivate var musicService: MusicServiceProtocol = API()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
    var itunesService = iTunesService()
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusic(_ searchWord: String) {
        itunesService.fetchMusic(searchWord: searchWord) { [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(let data):
                output?.fetchMusicOutput(data)
            case .failure(let error):
                print("ERROR:", error.localizedDescription)
            }
        }
        /*musicService.fetchMusic { [weak self] result in
         guard let self = self else { return }
         
         switch result {
         case .success(let musicData):
         let transformedResult = result.map { data in
         MusicData(resultCount: 1, results: [data])
         }
         self.output?.fetchMusicOutput(transformedResult)
         print(musicData)
         case .failure(let error):
         print("MUSIC FETCH ERROR:", error.localizedDescription)
         }
         }*/
    }
}
