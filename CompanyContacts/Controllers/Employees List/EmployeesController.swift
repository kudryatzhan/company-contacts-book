//
//  EmployeesController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    
    var currentCompany: Company!
    var employeeManager: EmployeeManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = currentCompany.name
        setupRightBarButtonItemAdd(with: #selector(addButtonTapped))
    }
    
    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.employeeManager = employeeManager
        createEmployeeController.delegate = self
        
        let navController = UINavigationController(rootViewController: createEmployeeController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}
