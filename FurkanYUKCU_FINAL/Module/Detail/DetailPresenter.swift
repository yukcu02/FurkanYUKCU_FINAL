//
//  DetailPresenter.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import UIKit

protocol DetailPresenterProtocol {
    func viewDidLoad()    
}
extension DetailPresenter {
    fileprivate enum Constants {
        static let pageTitle: String = "Detail"
    }
}
final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol!
    
    init(
        view: DetailViewControllerProtocol,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}
extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        guard let music = view.getSource() else { return }
        
        if let artworkUrlString = music.artworkUrl100 {
            guard let artworkURL = URL(string: artworkUrlString) else { return }         
        }
        view.setartistName(music.artistName ?? "")
        view.settrackPrice(music.trackPrice ?? 0.0)
        view.setcollectionPrice(music.collectionPrice ?? 0.0)
        view.setcollectionName(music.collectionName ?? "")
        view.setprimaryGenreName(music.primaryGenreName ?? "")
        view.settrackName(music.trackName ?? "")
    }
}
