//
//  VacanciesListPresenter.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

class VacanciesListPresenter {

    // MARK: Private Data Structures
    
    public enum ViewState {
        case initialLoading
        case refreshing
        case data
        case noData
        case additionalLoading
        case error
    }


	// MARK: Public Properties

    weak var view: IVacanciesListViewInput!
    weak var moduleOutput: IVacanciesListModuleOutput?


    // MARK: Private Properties

    private let interactor: IVacanciesListInteractorInput
    private let router: IVacanciesListRouterInput
    private let vacanciesListDisplaDataFactory: IVacanciesListDisplaDataFactory
    
    private(set) var viewState: ViewState = .initialLoading {
        didSet {
            updateView()
        }
    }
    
    private var vacancies: [Vacancy] = []




    // MARK: Lifecycle

    init(router: IVacanciesListRouterInput,
         interactor: IVacanciesListInteractorInput,
         vacanciesListDisplaDataFactory: IVacanciesListDisplaDataFactory) {
        self.router = router
        self.interactor = interactor
        self.vacanciesListDisplaDataFactory = vacanciesListDisplaDataFactory
    }
    
    // MARK: Private
    
    private func updateView() {
        
        func resetView() {
            view.stopInitialLoading()
            
            if viewState != .additionalLoading {
                view.hideAdditionalLoading()
            }

            if viewState != .refreshing {
                view.stopRefreshing()
            }
        }
        
        resetView()
        
        switch viewState {
        case .initialLoading:
            view.showInitialLoading()

        case .refreshing:
            break

        case .additionalLoading:
            view.showAdditionalLoading()

        case .data:
            break
            
        case .noData, .error:
            view.reloadTable()
        }
    }
}




// MARK: - IVacanciesListModuleInput

extension VacanciesListPresenter: IVacanciesListModuleInput {
    
}




// MARK: - IVacanciesListInteractorOutput

extension VacanciesListPresenter: IVacanciesListInteractorOutput {
    
    var dataCount: Int {
        return vacancies.count
    }
    
    func didRefreshVacancies(_ vacancies: [Vacancy]) {
        guard !vacancies.isEmpty else {
            viewState = .noData
            return
        }

        self.vacancies = vacancies
        viewState = .data
        view.reloadTable()
    }
    
    func didStartAditionalLoading() {
        viewState = .additionalLoading
    }
    
    func didFinishAditionalLoading(_ vacancies: [Vacancy]) {
        let startIndex = self.vacancies.count
        let endIndex = self.vacancies.count + vacancies.count - 1
        
        var indexPaths: [IndexPath] = []
        
        for index in startIndex...endIndex {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        
        self.vacancies += vacancies
        viewState = .data
        view.insertRows(at: indexPaths)
    }
    
    func didRecceiveError(_ error: Error) {
        view.showErrorMessage(error.localizedDescription)
        if vacancies.isEmpty {
            viewState = .error
        }
    }
}




// MARK: - IVacanciesListViewOutput

extension VacanciesListPresenter: IVacanciesListViewOutput {
    
    var numberOfRows: Int {
        return vacancies.count
    }
    
    func displayDataForRow(at indexPath: IndexPath) -> VacanciesListTableViewCell.DisplayData {
        let vacancy = vacancies[indexPath.row]
        
        return vacanciesListDisplaDataFactory.displayData(for: vacancy)
    }
    
    func viewDidLoadEvent() {
        viewState = .initialLoading
        interactor.refreshVacancies()
    }
    
    func userWanToStartRefresh() {
        viewState = .refreshing
        interactor.refreshVacancies()
    }
    
    func tableApproachesEndEvent() {
        interactor.additionaLoadVacancies()
    }
}
