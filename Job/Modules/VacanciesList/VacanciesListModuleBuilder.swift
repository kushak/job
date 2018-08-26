//
//  VacanciesListModuleBuilder.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

class VacanciesListModuleBuilder {
    
    struct InjectContainer {
        let vacanciesService: IVacanciesService
        let vacanciesListDisplaDataFactory: IVacanciesListDisplaDataFactory
    }

    class func viewController(container: InjectContainer, moduleOutput: IVacanciesListModuleOutput? = nil) -> UIViewController {
        
        let interactor = VacanciesListInteractor(vacanciesService: container.vacanciesService)
		let router = VacanciesListRouter()
		let presenter = VacanciesListPresenter(router: router,
                                               interactor: interactor,
                                               vacanciesListDisplaDataFactory: container.vacanciesListDisplaDataFactory)
        
		let vc = VacanciesListViewController()
		vc.output = presenter
		presenter.view = vc
        presenter.moduleOutput = moduleOutput
		router.transitionHandler = vc
		interactor.output = presenter

		return vc
    }
}
