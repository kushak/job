//
//  IVacanciesListViewInput.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

protocol IVacanciesListViewInput: IBaseViewInput {

    func showInitialLoading()
    func stopInitialLoading()
    
    func reloadTable()
    func insertRows(at indexPaths: [IndexPath])
    
    func showAdditionalLoading()
    func hideAdditionalLoading()
    
    func stopRefreshing()
}
