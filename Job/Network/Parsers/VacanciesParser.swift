//
//  VacanciesParser.swift
//  Job
//
//  Created by Oleg Shupulin on 20.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation


struct VacanciesParser: IParser {
    
    typealias Model = [Vacancy]
    
    private struct Response: Decodable {
        let result: Model
        
        enum CodingKeys: String, CodingKey {
            case result = "items"
        }
    }
    
    func parse(data: Data) throws -> Model {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(Response.self,
                                          from: data)
        return response.result
    }
}
