//
//  ActivitySummaryView.swift
//  ExpenseTracker
//
//  Created by Mohaimen Washik on 3/2/24.
//

import SwiftUI

struct ActivitySummaryView: View {
    @ObservedObject var expenseInfoDictionary: ExpenseDictionary
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            let entriesForWeek = expenseInfoDictionary.infoRepository.filter { $0.date >= sevenDaysAgo }
            
            List {
                ForEach(entriesForWeek, id: \.self) { record in
                    let formattedAmount = numberFormatter.string(from: NSNumber(value: record.amount ?? 0.0)) ?? "0.00"
                    Text("\(record.description ?? "") - \(formattedAmount) on \(record.formattedDate())")
                }
            }
            .navigationBarTitle("Weekly Summary")
        }
    }
}


