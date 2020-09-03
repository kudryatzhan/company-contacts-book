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
    
    private var employees = [Employee]()
    
    private var company: Company?
    
    var numberOfEmployees: Int {
        return employees.count
    }
    
    // MARK: - Initializers
    
    init(company: Company) {
        // FIXME: Fetch employees from specified company ONLY
        self.company = company
        fetchEmployees()
    }
    
    // MARK: - CRUD
    
    func employee(at index: Int) -> Employee {
        return employees[index]
    }
    
    func index(of employee: Employee) -> Int {
        guard let index = employees.firstIndex(of: employee) else {
            fatalError("Unexpected Employee.")
        }
        return index
    }
    
    func createEmployeeWith(name: String) -> Employee {
        let context = CoreDataManager.shared.context
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        newEmployee.setValue(name, forKey: "name")
        employees.append(newEmployee)
        
        // Set relationships
        newEmployee.company = company
    
        CoreDataManager.shared.saveContext()
        
        return newEmployee
    }
    
    // Core Data
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        self.employees = companyEmployees
    }
}
