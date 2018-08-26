//
//  RequestConfig.swift
//  Job
//
//  Created by Oleg Shupulin on 14.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}
