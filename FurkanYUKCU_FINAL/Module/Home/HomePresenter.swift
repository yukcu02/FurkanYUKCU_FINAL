import Foundation
import iTunesAPI

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func music(_ index: Int) -> Music?
    func didSelectRowAt(index: Int)
    func searchMusic(with keyword: String)
}

final class HomePresenter {
    
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var music: [Music] = []
    private var filteredMusic: [Music] = []
    private var currentSearchTask: DispatchWorkItem?
    
    init(
        view: HomeViewControllerProtocol,
        router: HomeRouterProtocol,
        interactor: HomeInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    private func fetchMusic(_ searchWord: String) {
        view.showLoadingView()
        interactor.fetchMusic(searchWord)
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("iTunes Search")
    }
    
    func numberOfItems() -> Int {
        music.count
    }
    
    func music(_ index: Int) -> Music? {
        return music[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = music(index) else { return }
        router.navigate(.detail(source: source))
    }
    
    func searchMusic(with keyword: String) {
        currentSearchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            self?.fetchMusic(keyword)
        }
        currentSearchTask = task
        
        DispatchQueue.main.async(execute: task)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchMusicOutput(_ result: [Music]) {
        music = result
        view.hideLoadingView()
        view.reloadData()
    }
}


