//
//  ExpenseRecord.swift
//  ExpenseTracker
//
//  Created by Mohaimen Washik on 2/29/24.
//

import Foundation

struct ExpenseRecord: Hashable
{
    var description:String? = nil
    var amount:Double? = nil
    var date:Date = .now
    
    init(d:String, a:Double, dateF:Date) {
        self.description = d
        self.amount = a
        self.date = dateF
    }
    
    func formattedDate() -> String 
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: date)
    }
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(date)
    }

    static func == (lhs: ExpenseRecord, rhs: ExpenseRecord) -> Bool 
    {
        return lhs.date == rhs.date
    }
}

class ExpenseManager
{
    func saveExpenseRecord(_ expenseRecord: [ExpenseRecord])
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
    }
}
