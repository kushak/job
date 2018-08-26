//
//  VacanciesListDisplaDataFactory.swift
//  Job
//
//  Created by Oleg Shupulin on 24.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation

protocol IVacanciesListDisplaDataFactory {
    
    func displayData(for vacancy: Vacancy) -> VacanciesListTableViewCell.DisplayData
}

class VacanciesListDisplaDataFactory {
    
    private lazy var currencyNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.groupingSize = 3
        numberFormatter.currencyGroupingSeparator = " "
        
        numberFormatter.groupingSeparator = numberFormatter.currencyGroupingSeparator
        numberFormatter.decimalSeparator = numberFormatter.currencyDecimalSeparator
        
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        
        numberFormatter.minimumIntegerDigits = 1
        
        numberFormatter.positivePrefix = ""
        numberFormatter.negativePrefix = "-"
        
        numberFormatter.isLenient = true
        
        numberFormatter.numberStyle = .currency
        
        return numberFormatter
    }()
    
    
    
    
    private func formattedSalary(for salary: Salary) -> String {
        guard salary.from != nil || salary.to != nil else { return "" }
        let currencySymbol = salary.currency
        
        var result = ""
        if let fromValue = salary.from {
            currencyNumberFormatter.currencySymbol = ""
            currencyNumberFormatter.positiveSuffix = ""
            let number = NSNumber(value: fromValue)
            result += currencyNumberFormatter.string(from: number) ?? ""
            
            if salary.to != nil {
                result += " - "
            }
        }
        
        if let toValue = salary.to {
            currencyNumberFormatter.currencySymbol = ""
            currencyNumberFormatter.positiveSuffix = ""
            let number = NSNumber(value: toValue)
            result += currencyNumberFormatter.string(from: number) ?? ""
        }
        
        result += " " + currencySymbol
        
        return result
    }
}




// MARK: - IVacanciesListDisplaDataFactory

extension VacanciesListDisplaDataFactory: IVacanciesListDisplaDataFactory {
    
    func displayData(for vacancy: Vacancy) -> VacanciesListTableViewCell.DisplayData {
        
        let salary = vacancy.salary.flatMap(formattedSalary) ?? ""
        
        let displayData =
            VacanciesListTableViewCell.DisplayData(vacancy: vacancy.name,
                                                   salary: salary,
                                                   company: vacancy.employer.name,
                                                   city: vacancy.area.name)
        
        return displayData
    }
}
