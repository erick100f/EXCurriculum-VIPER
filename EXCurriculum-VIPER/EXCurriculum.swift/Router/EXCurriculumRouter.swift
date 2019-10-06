//
//  EXCurriculumRouter.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/6/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation
import UIKit

class EXCurricumlumRouter:PresenterToRouterProtocol{

    static func createModule() -> EXCurriculumViewController {
        
        let view = EXCurriculumViewController()
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = EXCurriculumPresenter()
        let interactor: PresenterToInteractorProtocol = EXCurriculumInteractor()
        let router:PresenterToRouterProtocol = EXCurricumlumRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    func pushToAppScreen( navigationController:UINavigationController) {
        //TODO: -AappModile push
        
        
    }
    
}
