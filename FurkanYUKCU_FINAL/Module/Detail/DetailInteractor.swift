//
//  DetailInteractor.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

//Detay sayfasında veri çekilmeyecekse bu protocol tanımlanmayabilir
protocol DetailInteractorProtocol {
    
}

protocol DetailInteractorOutputProtocol {
    func fetchMusicDetailOutput(result: MusicSourcesResult)
}

final class DetailInteractor {
    var output: HomeInteractorOutputProtocol?
}
