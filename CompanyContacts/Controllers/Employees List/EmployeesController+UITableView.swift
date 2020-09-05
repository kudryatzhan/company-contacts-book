//
//  EmployeesController+UITableView.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension EmployeesController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return employeeManager.sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeManager.allEmployees[section].count
//        return employeeManager.employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.employeeCellReuseIdentifier, for: indexPath)
//        let employee = employeeManager.employees[indexPath.row]
        
        let employee = employeeManager.allEmployees[indexPath.section][indexPath.row]
    
        cell.textLabel?.text = employee.fullName
        
        if let birthday = employee.birthday {
            let birthdayText = DateFormatter.localizedString(from: birthday,
                                                             dateStyle: .medium,
                                                             timeStyle: .none)
            cell.detailTextLabel?.text = birthdayText
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EmployeesController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !employeeManager.allEmployees[section].isEmpty else { return nil }
        
        let headerLabel = IndentedLabel()
        
        headerLabel.text = employeeManager.sectionTitles[section]
        headerLabel.backgroundColor = .lightBlue
        headerLabel.textColor = .darkBlue
        headerLabel.font = .boldSystemFont(ofSize: 16)
        
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard !employeeManager.allEmployees[section].isEmpty else { return 0 }
        
        return 50
    }
}
