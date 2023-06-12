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

            ImageDownloader.shared.image(music: music) { data, error in // Değişiklik #1: imageURL parametresini kaldır
                guard let data = data, error == nil else { return }
                guard let image = UIImage(data: data) else { return }
                self.view.setmusicImg(image)
            }
        }

        view.setartistName(music.artistName ?? "")
        view.settrackPrice(music.trackPrice ?? 0.0)
        view.setcollectionPrice(music.collectionPrice ?? 0.0)
        view.setcollectionName(music.collectionName ?? "")
        view.setprimaryGenreName(music.primaryGenreName ?? "")
        view.settrackName(music.trackName ?? "")
    }
}



//extension DetailPresenter: DetailPresenterProtocol {
//    func viewDidLoad() {
//        guard let music = view.getSource() else { return }
//
//        if let artworkUrlString = music.artworkUrl100 {
//            guard let artworkURL = URL(string: artworkUrlString) else { return }
//
//            ImageDownloader.shared.image(music: music, imageURL: artworkURL) { [weak self] data, error in
//                guard let self = self, let data = data, error == nil else { return }
//                guard let image = UIImage(data: data) else { return }
//                self.view.setmusicImg(image)
//            }
//        }
//
//        view.setartistName(music.artistName ?? "")
//        view.settrackPrice(music.trackPrice ?? 0.0)
//        view.setcollectionPrice(music.collectionPrice ?? 0.0)
//        view.setcollectionName(music.collectionName ?? "")
//        view.setprimaryGenreName(music.primaryGenreName ?? "")
//        view.settrackName(music.trackName ?? "")
//    }
//}



//extension DetailPresenter: DetailPresenterProtocol {
//
//    func viewDidLoad() {
//
//        guard let music = view.getSource() else { return }
//
//        let musicData = MusicData(resultCount: 1, results: [music])
//        guard let artworkUrlString = music.artworkUrl100, let artworkURL = URL(string: artworkUrlString) else { return }
//        ImageDownloader.shared.image(music: musicData, imageURL: artworkURL) { [weak self] data, error in
//            guard let self = self, let data = data, error == nil else { return }
//            guard let image = UIImage(data: data) else { return }
//            self.view.setmusicImg(image)
//        }
//
//        view.setartistName(music.artistName ?? "")
//        view.settrackPrice(music.trackPrice ?? 0.0)
//        view.setcollectionPrice(music.collectionPrice ?? 0.0)
//        view.setcollectionName(music.collectionName ?? "")
//        view.setprimaryGenreName(music.primaryGenreName ?? "")
//        view.settrackName(music.trackName ?? "")
//    }
//}


//extension DetailPresenter: DetailPresenterProtocol {
  
//    func viewDidLoad() {
//
//        guard let music = view.getSource() else { return }
////        bu jumbo kısmıyla alakalı kaldırınca hata veriyor
//        ImageDownloader.shared.image(
//            music: music,
//            format: .superJumbo)
//        { [weak self] data, error in
//            guard let self else { return }
//            guard let data, error == nil else { return }
//            guard let image = UIImage(data: data) else { return }
//            self.view.setmusicImg(image)
//        }
//        view.setartistName(music.artistName ?? "")
////        buraları forceladım dikkat et düzeltilecek
//        view.settrackPrice(music.trackPrice! )
//        view.setcollectionPrice(music.collectionPrice! )
//        view.setcollectionName(music.collectionName ?? "")
//        view.setprimaryGenreName(music.primaryGenreName ?? "")
//        view.settrackName(music.trackName ?? "")
//
//    }
//}
