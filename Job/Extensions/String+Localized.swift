//
//  String+Localized.swift
//  Job
//
//  Created by Oleg Shupulin on 15.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
