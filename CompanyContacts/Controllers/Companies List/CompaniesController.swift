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
        setupRightBarButtonItemAdd(with: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(resetButtonTapped))
        extendedLayoutIncludesOpaqueBars = true
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView() // Blank footer
        tableView.register(CompanyCell.self, forCellReuseIdentifier: K.companyCellReuseIdentifier)
        tableView.separatorColor = .white
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 50
        
        // Refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Actions
    
    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {
        let createCompanyController = CreateEditCompanyController()
        createCompanyController.delegate = self
        createCompanyController.companyManager = companyManager
        
        let navController = UINavigationController(rootViewController: createCompanyController)
        navController.modalPresentationStyle = .fullScreen
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func resetButtonTapped(_ sender: UIBarButtonItem) {
        var indexPathsToRemove = [IndexPath]()
        for row in 0..<companyManager.companies.count {
            let indexPath = IndexPath(row: row, section: 0)
            indexPathsToRemove.append(indexPath)
        }
        
        companyManager.deleteAllCompanies()
        tableView.deleteRows(at: indexPathsToRemove, with: .left)
    }
    
    @objc fileprivate func handleRefreshControl(_ sender: UIRefreshControl) {
        companyManager.fetchCompaniesFromServer { (success) in
            if success {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}
