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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = currentCompany.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
    }
    
    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {
        let createEmployeeController = CreateEmployeeController()
        let navController = UINavigationController(rootViewController: createEmployeeController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}
