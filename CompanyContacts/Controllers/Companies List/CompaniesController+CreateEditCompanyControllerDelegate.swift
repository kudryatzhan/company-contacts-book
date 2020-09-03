//
//  CompaniesController+CreateEditCompanyControllerDelegate.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

// MARK: - CreateEditCompanyControllerDelegate

extension CompaniesController: CreateEditCompanyControllerDelegate {
    
    func didCreateCompany(_ company: Company) {
        let index = companyManager.index(of: company)
        let newIndexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }
    
    func didEditCompany(_ company: Company) {
        let index = companyManager.index(of: company)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
