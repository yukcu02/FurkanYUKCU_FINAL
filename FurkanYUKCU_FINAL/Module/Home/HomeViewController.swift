//
//  HomeViewController.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showError(_ message: String)
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
}

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: HomePresenterProtocol!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           searchBar.delegate = self
           // Do any additional setup after loading the view.
           presenter.viewDidLoad()
       }
   }


   extension HomeViewController: HomeViewControllerProtocol {
       
       func setupTableView() {
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(cellType: MusicCell.self)
       }
       
       func reloadData() {
           DispatchQueue.main.async { [weak self] in
               guard let self else { return }
               self.tableView.reloadData()
           }
       }
       
       func showError(_ message: String) {
           showAlert("Error", message)
       }
       
       func showLoadingView() {
           showLoading()
       }
       
       func hideLoadingView() {
           hideLoading()
       }
       
       func setTitle(_ title: String) {
           self.title = title
       }
       
       
   }

   extension HomeViewController: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           presenter.numberOfItems()
       }
       
       
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(with: MusicCell.self, for: indexPath)
         cell.selectionStyle = .none

         if let music = presenter.music(indexPath.row) {
             let cellInteractor = MusicCellInteractor()
             let presenter = MusicCellPresenter(
                 view: cell,
                 interactor: cellInteractor,
                 music: music
             )
             cellInteractor.output = presenter
             cell.cellPresenter = presenter

             cell.loadImage(urlString: music.artworkUrl100 ?? "")
         }

         return cell
     }

   }

   extension HomeViewController: UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           presenter.didSelectRowAt(index: indexPath.row)
       }
       
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 130
       }
       
   }

   extension HomeViewController: UISearchBarDelegate {
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           if let searchWord = searchBar.text {
               presenter.searchMusic(with: searchWord)
           }
           searchBar.resignFirstResponder()
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           //presenter.searchChange(searchText)
       }
   }
