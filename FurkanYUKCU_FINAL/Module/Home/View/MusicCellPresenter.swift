//
//  MusicCellPresenter.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 9.06.2023.
//

import UIKit
import iTunesAPI

protocol MusicCellPresenterProtocol: AnyObject {
    func load()
}
final class MusicCellPresenter {
    
    weak var view: MusicCellProtocol?
    let interactor: MusicCellInteractorProtocol!
    private let music: Music
    
    init(
        view: MusicCellProtocol?,
        interactor: MusicCellInteractorProtocol!,
        music: Music
    ){
        self.view = view
        self.interactor = interactor
        self.music = music
    }
}
extension MusicCellPresenter: MusicCellPresenterProtocol {
    func load() {
        if let url = music.artworkUrl100 {
            interactor.fetchImage(url)
        }
        
        view?.trackName(music.trackName ?? "")
        view?.artistName(music.artistName ?? "")
        view?.collectionName(music.collectionName ?? "")
    }
}

extension MusicCellPresenter: MusicCellInteractorOutputProcol {
    func onImageResult(_ data: Data?) {
        view?.musicImg(data ?? Data())
    }
}
