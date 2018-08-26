//
//  Salary.swift
//  Job
//
//  Created by Oleg Shupulin on 20.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation


struct Salary: Codable {
    let to: Int?
    let gross: Bool
    let from: Int?
    let currency: String
}
