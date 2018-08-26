//
//  VacanciesRequest.swift
//  Job
//
//  Created by Oleg Shupulin on 20.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation


struct VacanciesRequest: IRequest {
    var urlRequest: URLRequest? {
        let hardCodeUrlString = "https://api.hh.ru/vacancies?text=ios+developer&area=1&per_page=\(perPage)&page=\(page)"
        let url = URL(string: hardCodeUrlString)
        let urlRequest = url.flatMap { URLRequest(url: $0) }
        return urlRequest
    }
    
    private let page: Int
    private let perPage: Int
    
    init(page: Int, perPage: Int) {
        self.page = page
        self.perPage = perPage
    }
}
