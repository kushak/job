//
//  VacanciesListTableViewCell.swift
//  Job
//
//  Created by Oleg Shupulin on 22.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

final class VacanciesListTableViewCell: UITableViewCell {
    
    // MARK: Public Data Structures
    
    struct DisplayData {
        let vacancy: String
        let salary: String
        let company: String
        let city: String
    }
    
    // MARK: Pirvate properties
    
    private lazy var vacancyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .right
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
    
    func configure(with displayData: DisplayData) {
        vacancyLabel.text = displayData.vacancy
        salaryLabel.text = displayData.salary
        companyLabel.text = displayData.company
        cityLabel.text = displayData.city
    }
    
    
    // MARK: Private
    
    private func setupView() {
        addSubview(vacancyLabel)
        addSubview(salaryLabel)
        addSubview(companyLabel)
        addSubview(cityLabel)
        
        setupConstraints()
    }
}




// MARK: Constraints

extension VacanciesListTableViewCell {
    
    private func setupConstraints() {
        setupVacancyLabelConstraints()
        setupSalaryLabelConstraints()
        setupCompanyLabelConstraints()
        setupCityLabelConstraints()
    }
    
    private func setupVacancyLabelConstraints() {
        vacancyLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = [
            "vacancyLabel": vacancyLabel
        ]
        
        let salaryHuggingPriority = salaryLabel.contentHuggingPriority(for: .horizontal)
        vacancyLabel.setContentHuggingPriority(salaryHuggingPriority + 1,
                                               for: .horizontal)
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[vacancyLabel]",
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[vacancyLabel]",
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    private func setupSalaryLabelConstraints() {
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = [
            "salaryLabel": salaryLabel,
            "vacancyLabel": vacancyLabel
        ]
        
        let vacancyCompressionResistancePriority = vacancyLabel.contentCompressionResistancePriority(for: .horizontal)
        salaryLabel.setContentCompressionResistancePriority(vacancyCompressionResistancePriority + 1,
                                                            for: .horizontal)
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[vacancyLabel]-16-[salaryLabel]-16-|",
            options: .alignAllCenterY,
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    private func setupCompanyLabelConstraints() {
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = [
            "companyLabel": companyLabel,
            "vacancyLabel": vacancyLabel
        ]
        
        let cityHuggingPriority = cityLabel.contentHuggingPriority(for: .horizontal)
        companyLabel.setContentHuggingPriority(cityHuggingPriority + 1,
                                               for: .horizontal)
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[vacancyLabel]-[companyLabel]-|",
            metrics: nil,
            views: views)
        allConstraints += verticalConstraints
        
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[companyLabel]",
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    private func setupCityLabelConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: Any] = [
            "companyLabel": companyLabel,
            "cityLabel": cityLabel
        ]
        
        let companyCompressionResistancePriority = companyLabel.contentCompressionResistancePriority(for: .horizontal)
        cityLabel.setContentCompressionResistancePriority(companyCompressionResistancePriority + 1,
                                                          for: .horizontal)

        var allConstraints: [NSLayoutConstraint] = []

        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[companyLabel]-16-[cityLabel]-16-|",
            options: .alignAllCenterY,
            metrics: nil,
            views: views)
        allConstraints += horizontalConstraints

        NSLayoutConstraint.activate(allConstraints)
    }
}
