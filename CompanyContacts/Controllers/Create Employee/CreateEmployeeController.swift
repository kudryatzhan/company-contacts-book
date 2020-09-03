//
//  CreateEmployeeController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        view.backgroundColor = .darkBlue
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Create Employee"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelButtonTapped))
    }
    
    @objc fileprivate func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
