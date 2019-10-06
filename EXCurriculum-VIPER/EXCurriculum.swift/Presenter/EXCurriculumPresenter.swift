//
//  EXCurriculumPresenter.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/6/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation
import UIKit

class EXCurriculumPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingCv() {
        interactor?.fetchCv()
    }
    
    func showAppController(navigationController: UINavigationController) {
        router?.pushToAppScreen(navigationController: navigationController)
    }
    
}

extension EXCurriculumPresenter: InteractorToPresenterProtocol{
    
    func cvFetchedSuccess(cv: EXCurriculum) {
        view?.showCv(cv: cv)
    }
    
    func cvFetchFailed() {
        view?.showError()
    }
    
    
}
