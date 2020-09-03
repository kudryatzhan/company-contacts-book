//
//  CompaniesController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/2/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
    
    // MARK: - Properties
    
    var companyManager: CompanyManager!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - Helper methods
    
    fileprivate func setupNavigationBar() {
        // Navigation item
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(resetButtonTapped))
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView() // Blank footer
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellReuseIdentifier)
        tableView.separatorColor = .white
    }
    
    // MARK: - Actions
    
    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        createCompanyController.companyManager = companyManager
        
        let navController = UINavigationController(rootViewController: createCompanyController)
        navController.modalPresentationStyle = .fullScreen
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func resetButtonTapped(_ sender: UIBarButtonItem) {
        companyManager.deleteAllCompanies()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyManager.numberOfCompanies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReuseIdentifier, for: indexPath)
        let company = companyManager.company(at: indexPath.row)
        
        if let name = company.name, let founded = company.founded {
            let dateString = DateFormatter.localizedString(from: founded, dateStyle: .medium, timeStyle: .none)
            cell.textLabel?.text = "\(name) - Founded: \(dateString)"
        } else {
            cell.textLabel?.text = company.name
        }
        
        if let imageData = company.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        cell.backgroundColor = .cellColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            let editCompanyController = CreateCompanyController()
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
}

// MARK: - CreateCompanyControllerDelegate

extension CompaniesController: CreateCompanyControllerDelegate {
    
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
