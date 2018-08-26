//
//  RequestsFactory.swift
//  Job
//
//  Created by Oleg Shupulin on 14.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation

protocol IVacanciesAPIConfig: AnyObject {
    
    func getVacanciesConfig(forPage page: Int, withPerPage perPage: Int) -> RequestConfig<VacanciesParser>
}

final class RequestsFactory { }

extension RequestsFactory: IVacanciesAPIConfig {
    
    func getVacanciesConfig(forPage page: Int, withPerPage perPage: Int) -> RequestConfig<VacanciesParser> {
        
        let request = VacanciesRequest(page: page, perPage: perPage)
        let parser = VacanciesParser()
        
        return RequestConfig<VacanciesParser>(request: request,
                                              parser: parser)
    }
}
