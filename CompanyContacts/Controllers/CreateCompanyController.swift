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
            datePicker.date = companyToEdit?.founded ?? Date()
            if let imageData = companyToEdit?.imageData {
                companyImageView.image = UIImage(data: imageData)                
            }
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.maximumDate = Date()
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
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
        
        // Image view
        infoBackgroundView.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 16).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: infoBackgroundView.centerXAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.heightAnchor.constraint(equalTo: companyImageView.widthAnchor).isActive = true
        
        // Name label
        infoBackgroundView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 16).isActive = true
        
        // Name text field
        infoBackgroundView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        // Date picker
        infoBackgroundView.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: infoBackgroundView.centerXAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -16).isActive = true
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
        guard
            let companyName = nameTextField.text, !companyName.isEmpty,
            let imageData = companyImageView.image?.pngData() else { return }
        
        if companyToEdit != nil {
            companyManager.updateCompany(companyToEdit!, withName: companyName, date: datePicker.date, imageData: imageData)
            dismiss(animated: true) {
                self.delegate?.didEditCompany(self.companyToEdit!) // Safe to unwrap
            }
        } else {
            let newCompany = companyManager.createCompanyWith(name: companyName, date: datePicker.date, imageData: imageData)
            dismiss(animated: true) {
                self.delegate?.didCreateCompany(newCompany)
            }
        }
    }
    
    @objc fileprivate func handleSelectPhoto(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalPresentationStyle = .fullScreen
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage {
            companyImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
