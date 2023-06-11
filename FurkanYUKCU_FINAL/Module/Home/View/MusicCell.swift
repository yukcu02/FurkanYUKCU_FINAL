//
//  MusicCell.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 9.06.2023.
//

import UIKit

protocol MusicCellProtocol: AnyObject {

    func musicImg(_ image: UIImage)
    func trackName(_ text: String)
    func artistName(_ text: String)
    func collectionName(_ text: String)
}

final class MusicCell: UITableViewCell {

    @IBOutlet weak var musicImg: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var cellPresenter: MusicCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func playButton(_ sender: UIButton) {
//        TODO: butona basma aksiyonunu göster
    }
    
}

extension MusicCell: MusicCellProtocol {
    
    func musicImg(_ image: UIImage) {
        DispatchQueue.main.async {
            self.musicImg.image = image
        }
    }
    
    func trackName(_ text: String) {
        trackName.text = text
    }
    
    func artistName(_ text: String) {
        artistName.text = text
    }
    
    func collectionName(_ text: String) {
        collectionName.text = text
    }
}
