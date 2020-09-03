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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeManager.numberOfEmployees
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        let employee = employeeManager.employee(at: indexPath.row)
        
        cell.textLabel?.text = employee.name
        cell.backgroundColor = .cellColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        
        if let birthday = employee.birthday {
            let birthdayText = DateFormatter.localizedString(from: birthday,
                                                             dateStyle: .medium,
                                                             timeStyle: .none)
            cell.detailTextLabel?.text = birthdayText
            cell.detailTextLabel?.textColor = .white
        }
        
        return cell
    }
}
