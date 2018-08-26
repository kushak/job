//
//  UIView+Reusable.swift
//  Job
//
//  Created by Oleg Shupulin on 22.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

extension UIView {
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: reuseIdentifier, bundle: bundle)
    }
}
