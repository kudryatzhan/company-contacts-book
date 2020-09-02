//
//  CompaniesController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/2/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    
    // MARK: - Properties
    
    let companies = [
        Company(name: "Apple", foundDate: Date()),
        Company(name: "Google", foundDate: Date()),
        Company(name: "Facebook", foundDate: Date())
    ]

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
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView() // Blank footer
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellReuseIdentifier)
        tableView.separatorColor = .white
    }
    
    // MARK: - IBActions
    
    @objc fileprivate func addButtonTapped(_ sender: UIBarButtonItem) {
        let createCompanyController = CreateCompanyController()
        let navController = UINavigationController(rootViewController: createCompanyController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReuseIdentifier, for: indexPath)
        let company = companies[indexPath.row]
        
        cell.backgroundColor = .cellColor
        cell.textLabel?.text = company.name
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
}
