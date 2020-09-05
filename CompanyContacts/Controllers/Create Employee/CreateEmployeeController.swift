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
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/dd/yyyy"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: employeeManager.sectionTitles)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.selectedSegmentIndex = 0
        segControl.selectedSegmentTintColor = .darkBlue
        segControl.setTitleTextAttributes([.foregroundColor: UIColor.darkBlue], for: .normal)
        segControl.setTitleTextAttributes([.foregroundColor: UIColor.lightBlue], for: .selected)

        return segControl
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
        nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: infoBackgroundView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        // Birthday text field
        infoBackgroundView.addSubview(birthdayTextField)
        birthdayTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8).isActive = true
        birthdayTextField.trailingAnchor.constraint(equalTo: infoBackgroundView.layoutMarginsGuide.trailingAnchor).isActive = true
        birthdayTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        
        // Birthday label
        infoBackgroundView.addSubview(birthdayLabel)
        birthdayLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        birthdayLabel.centerYAnchor.constraint(equalTo: birthdayTextField.centerYAnchor).isActive = true
        birthdayLabel.trailingAnchor.constraint(equalTo: birthdayTextField.leadingAnchor, constant: -16).isActive = true
        
        // Segmented control
        infoBackgroundView.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 8).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: birthdayTextField.trailingAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc fileprivate func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveButtonTapped() {
        guard let employeeName = nameTextField.text, let birthdayText = birthdayTextField.text else { return }
        
        if employeeName.isEmpty {
            showAlertWith(title: "Name field is empty", message: "Please enter employee's name")
            return
        }
        
        if birthdayText.isEmpty {
            showAlertWith(title: "Empty birthday text", message: "Please enter your birthday date")
            return
        }
        
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            showAlertWith(title: "Date is invalid", message: "Please enter date in the format specified")
            return
        }
        
        let segmentedTitle = employeeManager.sectionTitles[segmentedControl.selectedSegmentIndex]
        let employeeType = EmployeeManager.EmployeeType(rawValue: segmentedTitle) ?? .executive
        
        let newEmployee = employeeManager.createEmployeeWith(name: employeeName, birthday: birthdayDate, type: employeeType)
        
        dismiss(animated: true) {
            self.delegate?.didAddEmployee(newEmployee)
        }
    }
}
