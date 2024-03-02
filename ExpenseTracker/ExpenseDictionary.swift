//
//  ExpenseDictionary.swift
//  ExpenseTracker
//
//  Created by Mohaimen Washik on 2/29/24.
//

import Foundation

class ExpenseDictionary: ObservableObject
{
    @Published var infoRepository : [ExpenseRecord] = []
    private let expenseManager = ExpenseManager()
    init() {}
    
    func add(_ description:String, _ amount:Double, _ date:Date)
    {
        let eRecord =  ExpenseRecord(d: description, a: amount, dateF: date)
        infoRepository.append(eRecord)
        
        expenseManager.saveExpenseRecord(infoRepository)
    }
    
    func search(d: String) -> ExpenseRecord? {
        return infoRepository.first { $0.description == d }
    }
    
    func getCount() -> Int
    {
        return infoRepository.count
    }

}
