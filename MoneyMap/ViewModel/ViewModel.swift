//
//  ViewModel.swift
//  MoneyMap
//
//  Created by Mohamed Fuad on 8/26/24.
//
import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedData: [Transaction] = []
    
    init() {
        container = NSPersistentContainer(name: "MoneyMap")
        container.loadPersistentStores { [self] description, error in
            if let error = error {
                print("Error loading data \(error)")
            } else {
                print("Successfully loaded data!")
            }
            fetchTransactions()
        }
    }
    
    func fetchTransactions() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        
        do {
            savedData = try container.viewContext.fetch(request)
            
        } catch let error {
            print("There is an error \(error)")
        }
    }
    
    func addTransaction(title: String,amount: Double,type: String) {
        let newTransaction = Transaction(context: container.viewContext)
        newTransaction.title = title
        newTransaction.amount = amount
        newTransaction.type = type
        newTransaction.date = Date()
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            
            fetchTransactions()
            print("saved data")
            
        } catch let error {
            print("error while saving data: \(error)")
        }
        
        
    }
    
}
