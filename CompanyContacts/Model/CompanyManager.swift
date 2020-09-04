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
    
    private(set) var companies = [Company]()
    
    // MARK: - Initializers
    
    init() {
        fetchCompaniesFromCD()
    }
    
    // MARK: - CRUD
    
    func createCompanyWith(name: String, date: Date, imageData: Data) -> Company {
        let context = CoreDataManager.shared.context
        let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context) as! Company
        
        newCompany.name = name
        newCompany.founded = date
        newCompany.imageData = imageData
        
        companies.append(newCompany)
        CoreDataManager.shared.saveContext()
        
        return newCompany
    }
    
    func index(of company: Company) -> Int {
        guard let index = companies.firstIndex(of: company) else {
            fatalError("Unexpected company.")
        }
        return index
    }
    
    func deleteCompany(at index: Int) {
        let companyToRemove = companies[index]
        companies.remove(at: index)
        
        CoreDataManager.shared.context.delete(companyToRemove)
        CoreDataManager.shared.saveContext()
    }
    
    func updateCompany(_ company: Company, withName name: String, date: Date, imageData: Data) {
        company.name = name
        company.founded = date
        company.imageData = imageData
        
        CoreDataManager.shared.saveContext()
    }
    
    func deleteAllCompanies() {
        do {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
            try CoreDataManager.shared.context.execute(batchDeleteRequest)
            companies.removeAll()
        } catch {
            print("Failed to execute batchDeleteRequest: \(error)")
        }
    }
    
    // Core Data
    
    private func fetchCompaniesFromCD() {
        do {
            let context = CoreDataManager.shared.context
            companies = try context.fetch(Company.fetchRequest())
        } catch {
            print("Error fetching from Core Data: \(error)")
        }
    }
}
