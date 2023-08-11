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
    var card: [CardModel] = []
    var transaction: [TransactionModel] = []
    var category: [CategoryModel] = []
    @Published var pickerArray = ["RUB","EUR","USD","GEL"]
    @AppStorage(PersistedKeys.currency.rawValue) var currency = "GEL"
    var firstLoadCategory: [CategoryModel] = [CategoryModel(category: "car", hide: false),
                                                         CategoryModel(category: "groceries", hide: false),
                                                         CategoryModel(category: "education", hide: false),
                                                         CategoryModel(category: "entertainment", hide: false),
                                                         CategoryModel(category: "repair", hide: false),
                                                         CategoryModel(category: "garden", hide: false),
                                                         CategoryModel(category: "cafes", hide: false),
                                                         CategoryModel(category: "mobile", hide: false),
                                                         CategoryModel(category: "utilities", hide: false)]
    
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
            self.category = RealmService.shared.getCategory()
    }
    func getTransactions(){
        transaction = RealmService.shared.getTransaction()
        let transactonFilter = transaction.filter{!$0.hide}
        let sorted = transactonFilter.sorted{$0.date < $1.date}
        self.transaction = sorted
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
    }
}
