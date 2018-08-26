//
//  VacanciesService.swift
//  Job
//
//  Created by Oleg Shupulin on 23.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation


protocol IVacanciesService {
    func getVacancies(forPage page: Int, withPerPage perPage: Int, completion: NetworkCompletionHandler<[Vacancy]>?)
}

class VacanciesService {
    
    // MARK: Private Propeties
    
    private let requestSender: IRequestSender
    private let requestsFactory: IVacanciesAPIConfig
    
    init(requestSender: IRequestSender,
         requestsFactory: IVacanciesAPIConfig) {
        self.requestSender = requestSender
        self.requestsFactory = requestsFactory
    }
    
}




// MARK: - IVacanciesService

extension VacanciesService: IVacanciesService {
    
    func getVacancies(forPage page: Int, withPerPage perPage: Int, completion: NetworkCompletionHandler<[Vacancy]>?) {
        let requestConfig = requestsFactory.getVacanciesConfig(forPage: page,
                                                               withPerPage: perPage)
        
        requestSender.send(config: requestConfig) { result in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
}
