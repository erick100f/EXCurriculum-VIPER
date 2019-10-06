//
//  EXCurriculumProtocols.swift
//  EXCurriculum-VIPER
//
//  Created by Erick Cienfuegos on 10/6/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingCv()
    func showAppController(navigationController:UINavigationController)

}

protocol PresenterToViewProtocol: class{
    func showCv(cv: EXCurriculum)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> EXCurriculumViewController
    func pushToAppScreen(navigationController:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchCv()
}

protocol InteractorToPresenterProtocol: class {
    func cvFetchedSuccess(cv:EXCurriculum)
    func cvFetchFailed()
}
