//
//  MusicCellInteractor.swift
//  FurkanYUKCU_FINAL
//
//  Created by Metin Tarık Kiki on 15.06.2023.
//

import Foundation
import iTunesAPI

protocol MusicCellInteractorProtocol {
    func fetchImage(_ imageURL: String)
}

protocol MusicCellInteractorOutputProcol {
    func onImageResult(_ data: Data?)
}

final class MusicCellInteractor {
    var output: MusicCellInteractorOutputProcol!
    let service = iTunesService()
}

extension MusicCellInteractor: MusicCellInteractorProtocol {
    func fetchImage(_ imageURL: String) {
        /*
         ImageDownloader.shared.image(music: music) { [weak self] data, error in
         guard let self = self else { return }
         
         if let error = error {
         print("Hata: \(error)")
         return
         }
         
         if let data = data {
         guard let img = UIImage(data: data) else { return }
         self.view?.musicImg(img)
         }
         }*/
        
        //TODO: itunes service'in içine image indiren metod yaz
        //TODO: service çağrı örneği:
       /*
        service.downloadImage(urlString : artworkUrl100 ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                output.onImageResult(data)
            case .failure(let error):
                print("error:", error.localizedDescription)
            }
        }
        */
    }
}
