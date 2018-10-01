//
//  VacanciesListInteractor.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//


class VacanciesListInteractor {

	// MARK: Private Data Structures
    
    private enum Constants {
        static let vacanciesPerPage = 20
    }

	
	// MARK: Public Properties

    weak var output: IVacanciesListInteractorOutput!


	// MARK: Private Properties
    
    private let vacanciesService: IVacanciesService
    private var isLastPage = false



    // MARK: Lifecycle

    init(vacanciesService: IVacanciesService) {
        self.vacanciesService = vacanciesService
	}
}


// MARK: - IVacanciesListInteractorInput

extension VacanciesListInteractor: IVacanciesListInteractorInput {
    
    func refreshVacancies() {
        vacanciesService.getVacancies(forPage: 0,  withPerPage: Constants.vacanciesPerPage) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let vacancies):
                strongSelf.output.didRefreshVacancies(vacancies)
                
            case .failure(let error):
                strongSelf.output.didRecceiveError(error)
            }
        }
    }
    
    func additionaLoadVacancies() {
        guard !isLastPage else { return }
        output.didStartAditionalLoading()
        let nextPage = output.dataCount / Constants.vacanciesPerPage
        vacanciesService.getVacancies(forPage: nextPage, withPerPage: Constants.vacanciesPerPage) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let vacancies):
                strongSelf.isLastPage = vacancies.count < Constants.vacanciesPerPage
                strongSelf.output.didFinishAditionalLoading(vacancies)
                
            case .failure(let error):
                strongSelf.output.didRecceiveError(error)
            }
        }
    }
}
