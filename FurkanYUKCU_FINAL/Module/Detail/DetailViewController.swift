//
//  DetailViewController.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func settrackPrice(_ title: Double)
    func setcollectionPrice(_ text: Double)
    func setcollectionName(_ text: String)
    func setartistName(_ text: String)
    func setprimaryGenreName(_ title: String)
    func settrackName(_ title: String)
    func setmusicImg(_ image: UIImage)
    func getSource() -> Music?
}

final class DetailViewController: BaseViewController {
    @IBOutlet weak var musicImg: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var primaryGenreName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    
    var presenter: DetailPresenterProtocol!
    var source: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
  
    @IBAction func playButton(_ sender: UIButton) {
    }
    

}

extension DetailViewController: DetailViewControllerProtocol {
    func setartistName(_ text: String) {
        self.artistName.text = text
    }
    
    func settrackPrice(_ price: Double) {
        self.trackPrice.text = "\(price)"
    }
    
    func setcollectionPrice(_ price: Double) {
        self.collectionPrice.text = "\(price)"
    }

    
    func setcollectionName(_ text: String) {
        self.collectionName.text = text
    }
    
    func setprimaryGenreName(_ text: String) {
        self.primaryGenreName.text = text
    }
    
    func settrackName(_ text: String) {
        self.trackName.text = text
    }
    
    func setmusicImg(_ image: UIImage) {
        DispatchQueue.main.async {
            self.musicImg.image = image
        }
    }
    
    func getSource() -> Music? {
        return source
    }
}
