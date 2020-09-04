//
//  EmployeeManager.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/3/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import CoreData

class EmployeeManager {
    
    // MARK: - Properties
    
    private(set) var employees = [Employee]()
    
    private var company: Company?
    
    // MARK: - Initializers
    
    init(company: Company) {
        self.company = company
        fetchEmployees()
    }
    
    // MARK: - CRUD
    
    func index(of employee: Employee) -> Int {
        guard let index = employees.firstIndex(of: employee) else {
            fatalError("Unexpected Employee.")
        }
        return index
    }
    
    func createEmployeeWith(name: String, birthday: Date) -> Employee {
        let context = CoreDataManager.shared.context
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        newEmployee.name = name
        newEmployee.birthday = birthday
        newEmployee.company = company // Set relationships
        
        employees.append(newEmployee)
        
        CoreDataManager.shared.saveContext()
        
        return newEmployee
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        self.employees = companyEmployees
    }
}
