//
//  CompaniesController+UITableView.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyManager.numberOfCompanies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.companyCellReuseIdentifier, for: indexPath) as! CompanyCell
        let company = companyManager.company(at: indexPath.row)

        if let name = company.name, let founded = company.founded {
            let dateString = DateFormatter.localizedString(from: founded, dateStyle: .medium, timeStyle: .none)
            cell.companyLabel.text = "\(name) - Founded: \(dateString)"
        } else {
            cell.companyLabel.text = company.name
        }
        
        if let imageData = company.imageData {
            cell.companyImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
}

// MARK: - UITableviewDelegate

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "No companies available..."
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (companyManager.numberOfCompanies == 0) ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            let editCompanyController = CreateEditCompanyController()
            editCompanyController.companyToEdit = self.companyManager.company(at: indexPath.row)
            editCompanyController.delegate = self
            editCompanyController.companyManager = self.companyManager
            
            let navController = UINavigationController(rootViewController: editCompanyController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
            completion(true)
        }
        editAction.backgroundColor = .lightGreen
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.companyManager.deleteCompany(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        deleteAction.backgroundColor = .lightRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesController = EmployeesController()
        let company = companyManager.company(at: indexPath.row)
        employeesController.currentCompany = company
        navigationController?.pushViewController(employeesController, animated: true)
    }
}
