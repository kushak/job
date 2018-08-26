//
//  IVacanciesListViewOutput.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

protocol IVacanciesListViewOutput: AnyObject {
    
    var viewState: VacanciesListPresenter.ViewState { get }
    var numberOfRows: Int { get }
    
    func displayDataForRow(at indexPath: IndexPath) -> VacanciesListTableViewCell.DisplayData
    
    func viewDidLoadEvent()
    func userWanToStartRefresh()
    func tableApproachesEndEvent()
}
