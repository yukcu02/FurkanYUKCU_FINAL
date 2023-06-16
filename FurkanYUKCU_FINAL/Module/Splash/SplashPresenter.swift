//
//  SplashPresenter.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}
final class SplashPresenter: SplashPresenterProtocol {
    
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(
        view: SplashViewControllerProtocol,
        router: SplashRouterProtocol,
        interactor: SplashInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}
extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.router.navigate(.homeScreen)
            }
        } else {
            view.noInternetConnection()
        }
    }
}
