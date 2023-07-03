//
//  DataSource.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 22.04.2023.
//

import Foundation
import SwiftUI

class DataSource: ObservableObject {
    
    static var shared = DataSource(); private init() { }
    
    @Published var categoriesSum: [(id: UUID, name: String, value: Double)] = []
    @Published var card: [CardModel] = []
    @Published var transaction: [TransactionModel] = []
    @Published var category: [CategoryModel] = []
    @Published var pickerArray = ["RUB","EUR","USD","GEL"]
    @AppStorage(PersistedKeys.currency.rawValue) var currency = "GEL"
    @Published var firstLoadCategory: [CategoryModel] = [CategoryModel(category: "car", hide: false), CategoryModel(category: "groceries", hide: false), CategoryModel(category: "education", hide: false), CategoryModel(category: "entertainment", hide: false), CategoryModel(category: "repair", hide: false), CategoryModel(category: "garden", hide: false), CategoryModel(category: "cafes", hide: false), CategoryModel(category: "mobile", hide: false), CategoryModel(category: "utilities", hide: false)]
    let today = Date()
    let calendar = Calendar.current
    
    func getMonth() -> Int{
        let currentMonth = calendar.component(.month, from: today)
        return currentMonth
    }
    func groupByDate() -> [(date: Date, items: [TransactionModel])] {
        let groupedItems = Dictionary(grouping: transaction) { item in
            Calendar.current.dateComponents([.year, .month], from: item.date)
        }
        let sortedGrouper = groupedItems.map { key, value in
            let date = Calendar.current.date(from: key)!
            return (date: date, items: value)
        }.sorted { $0.date > $1.date }
        return sortedGrouper
    }
    func addCategory(){
        for cat in firstLoadCategory{
            RealmService.shared.addCategory(cat)
        }
    }
    func removeCategory(){
        category = RealmService.shared.getCategory()
        let categoryFilter = category.filter{$0.hide}
        for cat in categoryFilter{
            RealmService.shared.delCategory(cat)
        }
    }
    func getGategory(){
        category = RealmService.shared.getCategory()
        self.category = category
    }
    func forGraphical(){
        let trans = transaction.filter {
            calendar.component(.month, from: $0.date) == getMonth()
        }
        categoriesSum.removeAll()
        let categories = Set(trans.map{$0.category})
        for categor in categories {
            let sum = trans.filter { $0.category == categor}.reduce(0){$0 + $1.amountInmainCurrency}
            let id = UUID()
            let tuple = (id: id, name: categor, value: sum)
            categoriesSum.append(tuple)
        }
        categoriesSum = categoriesSum.sorted { $0.value < $1.value }
    }
    func getTransactions(){
        transaction = RealmService.shared.getTransaction()
        let transactonFilter = transaction.filter{!$0.hide}
        let sorted = transactonFilter.sorted{$0.date < $1.date}
        self.transaction = sorted
        DataSource.shared.forGraphical()
    }
    func removeAllTransactions(){
        transaction = RealmService.shared.getTransaction()
        let transactonFilter = transaction.filter{$0.hide}
        for transaction in transactonFilter{
            RealmService.shared.delTransaction(transaction)
        }
    }
    func dropAllTransaction(){
        for trans in transaction{
            RealmService.shared.dropTransactionAmount(trans)
        }
    }
    func getCardsDB() {
        card = RealmService.shared.getCard()
        self.card = card
    }
    var getTransactionSum: Double {
        let trans = transaction.filter {
            calendar.component(.month, from: $0.date) == getMonth()
        }
        let sum = trans.reduce(0){$0 + $1.amountInmainCurrency}
        return sum
    }
}
