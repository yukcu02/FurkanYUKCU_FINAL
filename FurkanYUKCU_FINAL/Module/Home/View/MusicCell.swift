//
//  MusicCell.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 9.06.2023.
//

import UIKit
import AVFoundation
import iTunesAPI

protocol MusicCellProtocol: AnyObject {

    func musicImg(_ data: Data)
    func trackName(_ text: String)
    func artistName(_ text: String)
    func collectionName(_ text: String)
}

final class MusicCell: UITableViewCell {

    
    @IBOutlet weak var musicImg: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var musicData: Music?
      var audioPlayer: AVPlayer?
    var cellPresenter: MusicCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }


    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.musicImg.image = UIImage(data: data)
            }
        }.resume()
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
        if let audioPlayer = audioPlayer, audioPlayer.rate != 0 {
                 audioPlayer.pause()
                 sender.setTitle("Play", for: .normal)
                 return
             }

             if let audioPlayer = audioPlayer, audioPlayer.rate == 0 {
                 audioPlayer.play()
                 sender.setTitle("Pause", for: .normal)
                 return
             }

           guard let previewURL = musicData?.previewURL, let url = URL(string: previewURL) else {
               return
           }

           

             let playerItem = AVPlayerItem(url: url)
             audioPlayer = AVPlayer(playerItem: playerItem)

             audioPlayer?.play()
             sender.setTitle("Pause", for: .normal)
         }
       }


       extension MusicCell: MusicCellProtocol {

         func musicImg(_ data: Data) {
             DispatchQueue.main.async {
                 print("Image data received") // Debug statement
                 self.musicImg.image = UIImage(data: data)
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
