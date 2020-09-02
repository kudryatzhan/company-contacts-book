//
//  CompanyManager.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/2/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import CoreData

class CompanyManager {
    
    // MARK: - Properties
    
    private var companies = [Company]()
    
    var numberOfCompanies: Int {
        return companies.count
    }
    
    // MARK: - Initializers
    
    init() {
        fetchFromCoreData()
    }
    
    // MARK: - CRUD
    
    @discardableResult
    func createCompany(with name: String) -> Company {
        let context = CoreDataManager.shared.context
        let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context) as! Company
        newCompany.setValue(name, forKey: "name")
        companies.append(newCompany)
        CoreDataManager.shared.saveContext()
        
        return newCompany
    }
    
    func company(at index: Int) -> Company {
        return companies[index]
    }
    
    func index(of company: Company) -> Int {
        guard let index = companies.firstIndex(of: company) else {
            fatalError("Unexpected company.")
        }
        return index
    }
    
    private func fetchFromCoreData() {
        let context = CoreDataManager.shared.context
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            companies = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching from Core Data: \(error)")
        }
    }
}
