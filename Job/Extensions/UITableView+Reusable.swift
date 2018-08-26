//
//  UITableView+Reusable.swift
//  Job
//
//  Created by Oleg Shupulin on 22.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(for cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func registerCells<T: UITableViewCell>(for cellTypes: [T.Type]) {
        cellTypes.forEach(registerCell)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for cellType: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as! T
    }
}
