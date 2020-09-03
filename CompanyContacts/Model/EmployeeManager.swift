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
    
    var numberOfEmployees: Int {
        return employees.count
    }
    
    // MARK: - Initializers
    
    init(company: Company) {
        // FIXME: Fetch employees from specified company ONLY
        print(company.name!)
        fetchEmployeesFromCD()
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
    
    @discardableResult
    func createEmployeeWith(name: String) -> Employee {
        let context = CoreDataManager.shared.context
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        newEmployee.setValue(name, forKey: "name")
        
        employees.append(newEmployee)
        CoreDataManager.shared.saveContext()
        
        return newEmployee
    }
    
    // Core Data
    
    private func fetchEmployeesFromCD() {
        let context = CoreDataManager.shared.context
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            employees = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching from Core Data: \(error)")
        }
    }
}
