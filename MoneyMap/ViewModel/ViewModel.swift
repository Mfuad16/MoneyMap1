//
//  ViewModel.swift
//  MoneyMap
//
//  Created by Mohamed Fuad on 8/26/24.
//
import SwiftUI
import CoreData

enum TransactionType:String, Hashable, CaseIterable {
    case income = "income"
    case expense = "expense"
    
    var transactionTypeIcon: String {
        switch self {
        case .income:
            return "dollarsign.circle.fill"
        case .expense:
            return "creditcard.fill"
        }
    }
}

enum IncomeSubcategory: String, CaseIterable,Hashable {
    case salary = "Salary"
    case extraMoney = "Extra Money"
    case pocketMoney = "Pocket Money"
    case food = "Food"
    case clothes = "Clothes"
    case medical = "Medical"
    case education = "Education"
    case creditcard = "Credit Card"
    case shopping = "Shopping"
    case transport = "Transport"
    case electricbill = "Electric Bill"
    
    var transactiontypeicon: String {
        switch self {
        case .salary:
            return "dollarsign.circle"
            
        case .extraMoney:
            return "banknote"
        case .pocketMoney:
            return "wallet.pass"
        case .food:
            return "fork.knife"
        case .clothes:
            return "tshirt"
        case .medical:
            return "stethoscope"
        case .education:
            return "book"
        case .creditcard:
            return "creditcard"
        case .shopping:
            return "bag"
        case .transport:
            return "car"
        case .electricbill:
            return "bolt"
        }
    }
}
enum ExpenseSubcategory: String, CaseIterable, Hashable {
    case food = "Food"
    case clothes = "Clothes"
    case medical = "Medical"
    case education = "Education"
    case creditcard = "Credit Card"
    case shopping = "Shopping"
    case transport = "Transport"
    case electricbill = "Electric Bill"
    
    var transactiontypeicon: String {
        switch self {
        case .food:
            return "fork.knife"
        case .clothes:
            return "tshirt"
        case .medical:
            return "stethoscope"
        case .education:
            return "book"
        case .creditcard:
            return "creditcard"
        case .shopping:
            return "bag"
        case .transport:
            return "car"
        case .electricbill:
            return "bolt"
        }
    }
}

class ViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedData: [Transaction] = []
    @Published var totalIncome: Double = 0.0
    @Published var totalExpense: Double = 0.0
    
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
            totalIncome = savedData.filter { $0.type == TransactionType.income.rawValue }.reduce(0) { $0 + $1.amount }
                        
            totalExpense = savedData.filter { $0.type == TransactionType.expense.rawValue }.reduce(0) { $0 + $1.amount }
            
        } catch let error {
            print("There is an error \(error)")
        }
    }
    
    
   
    
    func addTransaction(title: String,amount: Double,type: String,date:Date,tranctype:String) {
        let newTransaction = Transaction(context: container.viewContext)
        newTransaction.title = title
        newTransaction.amount = amount
        newTransaction.type = type
        newTransaction.date = date
        newTransaction.tranctype = tranctype
        
        saveData()
    }
 
    func deleteTransaction(_ transaction: Transaction) {
            container.viewContext.delete(transaction)
            saveData()
        }
    
    
    func deleteAllTransactions() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Transaction")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(deleteRequest)
            saveData()  // This will call fetchTransactions() to update savedData
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
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
