//
//  MusicCellPresenter.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 9.06.2023.
//

import UIKit

protocol MusicCellPresenterProtocol: AnyObject {
    func load()
}
final class MusicCellPresenter {
    
    weak var view: MusicCellProtocol?
    private let music: Music
    
    init(
        view: MusicCellProtocol?,
         music: Music
    ){
        self.view = view
        self.music = music
    }
}
extension MusicCellPresenter: MusicCellPresenterProtocol {
   
    func load() {
        ImageDownloader.shared.image(
            music: music,
            format: .threeByTwoSmallAt2X)
        { [weak self] data, error in
            
            guard let self else { return }
            
            if let data {
                guard let img = UIImage(data: data) else { return }
                self.view?.musicImg(img)
            }
        }

        view?.trackName(music.trackName ?? "")
        view?.artistName(music.artistName ?? "")
        view?.collectionName(music.collectionName ?? "")
    }
}
