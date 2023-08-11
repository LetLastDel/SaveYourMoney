//
//  TransactionSettingModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 9.05.2023.
//

import Foundation

class TransactionSettingModel: ObservableObject {
    private var dataSource = DataSource.shared

    
    @Published var selectedCat = CategoryModel()
    @Published var addCat: CategoryModel = CategoryModel(category: "addedBal", hide: false)
    @Published var category: [CategoryModel] = []

    
    
    
    func getCategory(){
        dataSource.getGategory()
        category = dataSource.category
        selectedCat = category[0]
        
    }
    
    var transaction: TransactionModel
    @Published var text: String = ""
    @Published var date = Date()
    
    init(transaction: TransactionModel){
        self.transaction = transaction
    }
    func time() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH.mm"
        let dateString = dateFormatter.string(from: transaction.date)
        return dateString
    }
    func deleteTransaction() {
        changeTransaction()
        RealmService.shared.delTransaction(self.transaction)
    }
    func hideTrans(){
        RealmService.shared.hideTrans(transaction, hide: true)
        changeTransaction()
    }
    func changeTransaction(){
        if let card = RealmService.shared.getCard().first(where: {$0.id == transaction.cardID || $0.name == transaction.name}){
            let oldAmount = transaction.amount
            let amountInMain = (Double(text) ?? 0) / transaction.rates
            let newAmount = Double(text) ?? 0
            if transaction.category != "addedBal".localized{
                RealmService.shared.changeBalance(card, addbalance: oldAmount)
                RealmService.shared.spendBalance(card, spendModey: newAmount)
                RealmService.shared.changeTransaction(transaction, categ: selectedCat.category, dat: date, sum: newAmount, mainSum: amountInMain)
            } else {
                RealmService.shared.changeBalance(card, addbalance: -oldAmount)
                RealmService.shared.spendBalance(card, spendModey: -newAmount)
                RealmService.shared.changeTransaction(transaction, categ: addCat.category, dat: date, sum: newAmount, mainSum: amountInMain)
            }
        }
    }
}

