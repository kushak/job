//
//  IVacanciesListInteractorOutput.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation

protocol IVacanciesListInteractorOutput: AnyObject {

    var dataCount: Int { get }
    
//    func didRefreshVacancies(with result: Result<[Vacancy]>)
//    func didFinishAditionalLoading(with result: Result<[Vacancy]>)
    
    func didRefreshVacancies(_ vacancies: [Vacancy])
    
    func didStartAditionalLoading()
    func didFinishAditionalLoading(_ vacancies: [Vacancy])
    
    func didRecceiveError(_ error: Error)
}
