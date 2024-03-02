//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Mohaimen Washik on 2/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenseInfoDictionary:ExpenseDictionary = ExpenseDictionary()
    
    @State private var expenseDecription:String
    @State private var amountInDollars:String
    @State private var date:Date = .now
    @State private var threshold:String
    
    @State private var earningSelected = false
    @State private var expenseSelected = false
    
    init() 
    {
        _expenseDecription = State(initialValue: "")
        _amountInDollars = State(initialValue: "")
        _date = State(initialValue: Date())
        _threshold = State(initialValue: "")
    }   //end of init
    
    var body: some View {
        NavigationView{
            VStack {
                EntryView(descriptionE: $expenseDecription, amountE: $amountInDollars, dateE: $date, thresholdE: $threshold)
                ButtonView(descriptionB: $expenseDecription, amountB: $amountInDollars, dateB: $date, thresholdB: $threshold, earningSelectedB: $earningSelected, expenseSelectedB: $expenseSelected, eModel: expenseInfoDictionary)
                Spacer()
            }   //end of VStack
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Expense Tracker App")
            .navigationBarItems(trailing: NavigationLink(destination: ActivitySummaryView(expenseInfoDictionary: expenseInfoDictionary)) {
                            Text("Summary")
                        })
        }   //end of NavigationView
    }   //end of body
}   //end of ContentView

struct EntryView: View
{
    @Binding var descriptionE:String
    @Binding var amountE:String
    @Binding var dateE:Date
    @Binding var thresholdE:String
    
    @State var isPresented = true

    var body: some View 
    {
        Text(" ")
        HStack{
           
            Text("Threshold:")
                .foregroundColor(.blue)
            Spacer()
            TextField("In US Dollars", text: $thresholdE)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
        }
        
        HStack{
           
            Text("Amount:")
                .foregroundColor(.blue)
            Spacer()
            TextField("In US Dollars", text: $amountE)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
        }
        
        HStack
        {
            DatePicker("Date", selection: $dateE, displayedComponents: .date)
                .foregroundColor(.blue)
        }
        
        HStack{
            Text("Description:")
                .foregroundColor(.blue)
            Spacer()
        }
    }   //end of body View
}   //end of NavigationView

struct ButtonView: View 
{
    @Binding var descriptionB:String
    @Binding var amountB:String
    @Binding var dateB:Date
    @Binding var thresholdB:String
    
    @Binding var earningSelectedB:Bool
    @Binding var expenseSelectedB:Bool
    
    @State var expenseSum:Double = 0.0
    @State var earningSum:Double = 0.0
    @State var showInfo = false
    
    @ObservedObject var eModel: ExpenseDictionary
    
    var body: some View {
        Text("")
        VStack{
            // The HStack for the Earning and Expense Button
            HStack
            {
                Spacer()
                Spacer()
                // Earning button
                Button(action:
                        {
                    earningSelectedB = true
                    expenseSelectedB = false
                    descriptionB = "Earning"
                    print("Earnings: ", earningSum)
                    print("Earnings: ", amountB, " on ", dateB)
                }) {
                    if earningSelectedB == false
                    {
                        Text("Earning")
                            .padding()
                            .frame(width:90, height: 30)
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }   // end of if earningSelected == false
                    else
                    {
                        Text("Earning")
                            .padding()
                            .frame(width:90, height: 30)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }   //end of else
                }   //end of Earning Buttons
                .padding()
                .frame(width:100, height: 10)
                
                // Expense button
                Button(action:
                        {
                    expenseSelectedB = true
                    earningSelectedB = false
                    descriptionB = "Expense"
                    print("Expenses: ", expenseSum)
                    print("Expenses: ", amountB, " on ", dateB)
                }) {
                    if expenseSelectedB == false
                    {
                        Text("Expense")
                            .padding()
                            .frame(width:100, height: 30)
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }   // end of if expenseSelected == false
                    else
                    {
                        Text("Expense")
                            .padding()
                            .frame(width:100, height: 30)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }   //end of else
                }   //end of Expense Button
                .padding()
                .frame(width:120, height: 10)
            }   //end of first HStack
            
            // The HStack for the Save and Data List Buttons
            HStack
            {
                // Save Button
                Button(action:
                        {
                    if earningSelectedB == true
                    {
                        earningSum += Double(amountB) ?? 0.0
                    }
                    
                    if expenseSelectedB == true
                    {
                        expenseSum += Double(amountB) ?? 0.0
                    }
                    eModel.add(descriptionB, Double(amountB) ?? 0.0, dateB)
                    //Clear input fields after saving
                    descriptionB = ""
                    amountB = ""
                    dateB = Date()
                    earningSelectedB = false
                    expenseSelectedB = false
                }) {
                    Text("Save")
                        .padding()
                        .frame(width:150, height: 40)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }   //end of Save Button
                .padding()
            }   //end of second HStack
            
            // Spending Habbit Button
            Button(action:
                    {
                print("Sum of earning: ", earningSum)
                print("Sum of expenses: ", expenseSum)
                showInfo = true
            }) {
                Text("Tell my Spending Habbit")
                    .padding()
                    .frame(width:340, height: 40)
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.blue, lineWidth: 1)
                    ).sheet(isPresented: $showInfo) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.black)
                            .frame(width: 300, height: 100) // Set your desired width and height
                            .overlay(
                                VStack(alignment: .leading) {
                                    let verdict = earningSum - expenseSum
                                    if verdict > 0 && Double(thresholdB) ?? 0.0 < verdict
                                    {
                                        Text("You save some good money!")
                                            .foregroundStyle(Color.white)
                                    }
                                    else if verdict < 0 && expenseSum > Double(thresholdB) ?? 0.0
                                    {
                                        Text("You spent too much!")
                                            .foregroundStyle(Color.white)
                                    }
                                    else
                                    {
                                        Text("You have a normal budget now!")
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            )   // end of Overlay
                    }   //end of sheet
            }
            .padding()
        }   //end of VStack
    }   //end of View
}   //end ButtonView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
