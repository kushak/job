//
//  IBaseViewInput.swift
//  Job
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

protocol IBaseViewInput: AnyObject {
    
    func showErrorMessage(_ message: String)
}


extension IBaseViewInput where Self: UIViewController {
    
    func showErrorMessage(_ message: String) {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        let ation = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(ation)
        
        present(alert, animated: true, completion: nil)
    }
}
