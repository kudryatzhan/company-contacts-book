//
//  CreateEmployeeController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate: class {
    func didAddEmployee(_ employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    // MARK: - Properties
    
    var employeeManager: EmployeeManager!
    
    weak var delegate: CreateEmployeeControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
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
        // Info background view
        let infoBackgroundView = setupLightBlueBackgroundView()
        
        // Name label
        infoBackgroundView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 16).isActive = true
        
        // Name text field
        infoBackgroundView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: infoBackgroundView.layoutMarginsGuide.trailingAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -16).isActive = true
    }
    
    // MARK: - Actions
    
    @objc fileprivate func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveButtonTapped() {
        guard let employeeName = nameTextField.text, !employeeName.isEmpty else { return }
        let newEmployee = employeeManager.createEmployeeWith(name: employeeName)
        
        dismiss(animated: true) {
            self.delegate?.didAddEmployee(newEmployee)
        }
    }
}
