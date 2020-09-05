//
//  ServiceManager.swift
//  CompanyContacts
//
//  Created by Kudryatzhan Arziyev on 9/5/20.
//  Copyright © 2020 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

struct ServiceManager {
    
    static let shared = ServiceManager()
    
    private let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func downloadCompaniesFromServer(completion: @escaping ([CompanyData]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([CompanyData].self, from: data!)
                completion(decodedData)
            } catch {
                completion(nil)
                print("Error decoding json: \(error)")
            }
            
        }
        dataTask.resume()
    }
}

struct CompanyData: Decodable {
    let name: String
    let photoUrl: String
    let founded: String
    
    let employees: [EmployeeData]?
}

struct EmployeeData: Decodable {
    let name: String
    let birthday: String
    let type: String
}
