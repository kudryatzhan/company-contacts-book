//
//  CreateCompanyController.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/2/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate: class {
    func didCreateCompany(_ company: Company)
    func didEditCompany(_ company: Company)
}

class CreateCompanyController: UIViewController {
    
    // MARK: - Properties
    
    var companyManager: CompanyManager!
    weak var delegate: CreateCompanyControllerDelegate?
    
    var companyToEdit: Company? {
        didSet {
            nameTextField.text = companyToEdit?.name
        }
    }
    
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
        
        view.backgroundColor = .darkBlue
        setupNavigationBar()
        setupUI()
    }
    
    // MARK: - Helper methods
    
    fileprivate func setupUI() {
        // Info background view
        let infoBackgroundView = UIView()
        infoBackgroundView.backgroundColor = .lightBlue
        infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoBackgroundView)
        
        infoBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        infoBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Name label
        infoBackgroundView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 16).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -16).isActive = true
        
        // Name text field
        infoBackgroundView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: infoBackgroundView.centerYAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
    }
    
    fileprivate func setupNavigationBar() {
        if companyToEdit != nil {
            navigationItem.title = "Edit Company"
        } else {
            navigationItem.title = "Create Company"
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
    }
    
    @objc fileprivate func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let companyName = nameTextField.text, !companyName.isEmpty else { return }
        
        if companyToEdit != nil {
            companyManager.updateCompany(companyToEdit!, withName: companyName)
            dismiss(animated: true) {
                self.delegate?.didEditCompany(self.companyToEdit!) // Safe to unwrap
            }
        } else {
            let newCompany = companyManager.createCompany(with: companyName)
            dismiss(animated: true) {
                self.delegate?.didCreateCompany(newCompany)
            }
        }
    }
}
