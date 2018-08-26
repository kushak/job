//
//  Vacancy.swift
//  Job
//
//  Created by Oleg Shupulin on 20.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation

struct Vacancy: Codable {
    let salary: Salary?
    let name: String
    let area: Area
    let employer: Employer
    let publishedAt: Date
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id, salary, name
        case area, employer
        case publishedAt = "published_at"
    }
}
