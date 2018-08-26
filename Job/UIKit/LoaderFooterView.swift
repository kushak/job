//
//  LoaderFooterView.swift
//  Job
//
//  Created by Oleg Shupulin on 24.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

public final class LoaderFooterView: UIView {
    
    // MARK: Private data structures
    
    private enum Constants {
        static let height: CGFloat = 90
    }
    
    
    // MARK: Private properties
    
    private var activityIndicator: UIActivityIndicatorView
    
    
    
    
    // MARK: Lifecycle
    
    public convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 0, height: Constants.height)
        self.init(frame: frame)
    }
    
    public override init(frame: CGRect) {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        super.init(frame: frame)
        configureActivityIndicator()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        super.init(coder: aDecoder)
        configureActivityIndicator()
    }
    
    
    // MARK: Public
    
    public func displayLoader(_ needsToDisplay: Bool) {
        if needsToDisplay {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        activityIndicator.isHidden = !needsToDisplay
    }
    
    
    // MARK: Private
    
    private func configureActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: activityIndicator,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        
        let centerY = NSLayoutConstraint(item: activityIndicator,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        let constraints = [centerX, centerY]
        NSLayoutConstraint.activate(constraints)
    }
}
