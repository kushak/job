//
//  IParser.swift
//  Job
//
//  Created by Oleg Shupulin on 20.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation


protocol IParser {
    associatedtype Model
    func parse(data: Data) throws -> Model
}
