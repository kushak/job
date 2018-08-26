//
//  PlaceholderTableCell.swift
//  Job
//
//  Created by Oleg Shupulin on 25.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

class PlaceholderTableCell: UITableViewCell {
    
    // MARK: Pirvate properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // MARK: Public
    
    func configure(withText text: String) {
        titleLabel.text = text
    }
    
    
    // MARK: Private
    
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = [
            "titleLabel": titleLabel
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[titleLabel]|",
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[titleLabel]-16-|",
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        NSLayoutConstraint.activate(allConstraints)
    }
}
