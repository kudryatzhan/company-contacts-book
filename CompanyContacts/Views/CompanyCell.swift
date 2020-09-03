//
//  CompanyCell.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .cellColor
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        // Image view
        contentView.addSubview(companyImageView)
        companyImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        companyImageView.heightAnchor.constraint(equalTo: companyImageView.widthAnchor).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        companyImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        
        // Label
        contentView.addSubview(companyLabel)
        companyLabel.centerYAnchor.constraint(equalTo: companyImageView.centerYAnchor).isActive = true
        companyLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 16).isActive = true
        companyLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}
