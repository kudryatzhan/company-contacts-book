//
//  Helpers.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/5/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    
    formatter.dateFormat = "MM/dd/yyyy"
    
    return formatter
}()
