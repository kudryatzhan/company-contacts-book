//
//  EmployeeController+ CreateEmployeeControllerDelegate?.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

// MARK: - CreateEmployeeControllerDelegate

extension EmployeesController: CreateEmployeeControllerDelegate {
    
    func didAddEmployee(_ employee: Employee) {
        let index = employeeManager.index(of: employee)
        let newIndexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }
}
