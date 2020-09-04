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
        let employeeIndexPath = employeeManager.indexPath(of: employee)
        
        tableView.insertRows(at: [employeeIndexPath], with: .automatic)
        tableView.scrollToRow(at: employeeIndexPath, at: .bottom, animated: true)
    }
}
