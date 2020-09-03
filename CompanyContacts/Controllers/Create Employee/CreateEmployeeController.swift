//
//  CreateEmployeeController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
        view.backgroundColor = .darkBlue
    }
    
    // MARK: - Helper methods
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Create Employee"
        
        setupLeftBarButtonItemCancel(with: #selector(cancelButtonTapped))
        setupRightBarButtonItemSave(with: #selector(saveButtonTapped))
    }
    
    fileprivate func setupUI() {
        let infoBackgroundView = setupLightBlueBackgroundView()
    }
    
    // MARK: - Actions
    
    @objc fileprivate func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
