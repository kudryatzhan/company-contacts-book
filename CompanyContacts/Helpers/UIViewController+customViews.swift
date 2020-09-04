//
//  UIViewController+customViews.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Info background view
    // It will computer its height constraint after
    // subviews are added to it and configured properly
    func setupLightBlueBackgroundView() -> UIView {
        let infoBackgroundView = UIView()
        infoBackgroundView.backgroundColor = .lightBlue
        infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoBackgroundView)
        
        infoBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return infoBackgroundView
    }
    
    // Left bar button item - Cancel
    func setupLeftBarButtonItemCancel(with selector: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: selector)
    }
    
    // Right bar button item - Save
    func setupRightBarButtonItemSave(with selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: selector)
    }
    
    // Right bar button item - Add
    func setupRightBarButtonItemAdd(with selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: selector)
    }
    
    // Alert with single "OK" action
    func showAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
