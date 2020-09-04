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
    
//    private(set) var employees = [Employee]()
//    private(set) var shortNameEmployees = [Employee]()
//    private(set) var longNameEmployees = [Employee]()
//    private(set) var veryLongNameEmployees = [Employee]()
    
    private(set) var allEmployees = [[Employee]]()
    let sectionTitles = ["Short Names", "Long Names", "Very Long Names"]
    
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
//        guard let index = employees.firstIndex(of: employee) else {
//            fatalError("Unexpected Employee.")
//        }
    }
    
    func createEmployeeWith(name: String, birthday: Date) -> Employee {
        let context = CoreDataManager.shared.context
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        newEmployee.name = name
        newEmployee.birthday = birthday
        newEmployee.company = company // Set relationships
        
        if name.count < 6 {
            allEmployees[0].append(newEmployee)
        } else if name.count < 9 {
            allEmployees[1].append(newEmployee)
        } else {
            allEmployees[2].append(newEmployee)
        }
//        employees.append(newEmployee)
        
        CoreDataManager.shared.saveContext()
        
        return newEmployee
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
    
//        self.employees = companyEmployees
        let shortNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            guard let count = employee.name?.count else { return false }
            
            return count < 6
        })
        
        let longNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            guard let count = employee.name?.count else { return false }
            
            return count >= 6 && count < 9
        })
        
        let veryLongNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            guard let count = employee.name?.count else { return false }
            
            return count >= 9
        })
        
        allEmployees = [
            shortNameEmployees,
            longNameEmployees,
            veryLongNameEmployees
        ]
    }
}
