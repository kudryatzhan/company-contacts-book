//
//  EmployeeManager.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import CoreData

class EmployeeManager {
    
    // MARK: - Nested types
    
    enum EmployeeType: String {
        case executive        = "Executive"
        case seniorManagement = "Senior Management"
        case staff            = "Staff"
    }
    
    // MARK: - Properties
        
    private(set) var allEmployees = [[Employee]]()
    let sectionTitles = ["Executive", "Senior Management", "Staff"]
    
    private var company: Company?
    
    // MARK: - Initializers
    
    init(company: Company) {
        self.company = company
        fetchEmployees()
    }
    
    // MARK: - CRUD
    
    func indexPath(of employeeToMatch: Employee) -> IndexPath {

        for (sectionIndex, sectionArray) in allEmployees.enumerated() {
            for (rowIndex, employee) in sectionArray.enumerated() where employee == employeeToMatch  {
                return IndexPath(row: rowIndex, section: sectionIndex)
            }
        }
        
        fatalError("Could't locate employee to match")
    }
    
    func createEmployeeWith(name: String, birthday: Date, type: EmployeeType) -> Employee {
        let context = CoreDataManager.shared.context
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        newEmployee.name = name
        newEmployee.birthday = birthday
        newEmployee.company = company // Set relationships
        newEmployee.type = type.rawValue
        
        switch type {
        case .executive:
            allEmployees[0].append(newEmployee)
            
        case .seniorManagement:
            allEmployees[1].append(newEmployee)

        case .staff:
            allEmployees[2].append(newEmployee)
        }

        CoreDataManager.shared.saveContext()
        
        return newEmployee
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }

        let executiveEmployees = companyEmployees.filter { $0.type == EmployeeType.executive.rawValue }
        let seniorManagementEmployees = companyEmployees.filter { $0.type == EmployeeType.seniorManagement.rawValue }
        let staffEmployees = companyEmployees.filter { $0.type == EmployeeType.staff.rawValue }
        
        allEmployees = [
            executiveEmployees,
            seniorManagementEmployees,
            staffEmployees
        ]
    }
}
