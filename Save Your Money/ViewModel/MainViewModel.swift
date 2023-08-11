//
//  MainViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    private var dataSource = DataSource.shared
    
    @Published var cards: [CardModel] = []
    @Published var transactionSum: Double = 0.0
    @Published var transactions: [TransactionModel] = [] 
    @Published var categoriesSum: [(id: UUID, name: String, value: Double)] = []
     private  let today = Date()
     private  let calendar = Calendar.current
       
    init() {
        getCards()
        getTransactions()
    }
    func getMonth() -> Int{
        let currentMonth = calendar.component(.month, from: today)
        return currentMonth
    }
    func getTransactionsSum(){
        let trans = transactions.filter {
            calendar.component(.month, from: $0.date) == getMonth()
        }
        transactionSum = trans.reduce(0){$0 + $1.amountInmainCurrency}
    }
    func getCards() {
        dataSource.getCardsDB()
        cards = dataSource.card
    }
    func getTransactions(){
        dataSource.getTransactions()
        transactions = dataSource.transaction
        getTransactionsSum()
        forGraphical()
    }
    func checkCardDB() -> Bool {
        return !cards.isEmpty
    }
    func forGraphical(){
        let trans = transactions.filter {
            calendar.component(.month, from: $0.date) == getMonth()
        }
        categoriesSum.removeAll()
        let categories = Set(trans.map{$0.category})
        for categor in categories {
            let sum = transactions.filter { $0.category == categor}.reduce(0){$0 + $1.amountInmainCurrency}
            let id = UUID()
            let tuple = (id: id, name: categor, value: sum)
            categoriesSum.append(tuple)
        }
        categoriesSum = categoriesSum.sorted { $0.value < $1.value }
    }
}
