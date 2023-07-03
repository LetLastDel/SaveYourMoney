//
//  RealmComponents.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 19.04.2023.
//
import Foundation
import RealmSwift

class RealmService{
    static let shared = RealmService() ; private init () { }
    
    private let dbCard = try! Realm()
    private let dbTransaction = try! Realm()
    private let dbCategory = try! Realm()

    
    var config: Realm.Configuration {
        dbCard.configuration
    }
    //Category
    func addCategory(_ category: CategoryModel){
        do{
            try dbCategory.write{
                dbCategory.add(category)
            }
        } catch {
            print("Add category error")
        }
    }
    func getCategory() -> [CategoryModel]{
        let categoryList = dbCategory.objects(CategoryModel.self)
        var cat = [CategoryModel]()
        for categ in categoryList{
            cat.insert(categ, at: 0)
        }
        return cat
    }
    func delCategory(_ category: CategoryModel){
        do{
            try dbCategory.write{
                dbCategory.delete(category)
            }
        } catch {
            print("Delete category error")
        }
    }
    func hideCategory(_ category: CategoryModel, hide: Bool){
        do{
            try dbCategory.write{
                category.hide = hide
            }
        } catch {
            print("Change category error")
        }
    }
//Transactions
    func addTransaction(_ transaction: TransactionModel){
        do{
            try dbTransaction.write{
                dbTransaction.add(transaction)
            }
        } catch {
            print("Add category error")
        }
    }
    func dropTransactionAmount(_ transaction: TransactionModel){
        do{
            try dbTransaction.write{
                transaction.amountInmainCurrency = 0
            }
        } catch {
            print("Drop transaction error")
        }
    }
    func getTransaction() -> [TransactionModel]{
        let transList = dbTransaction.objects(TransactionModel.self)
        var trans = [TransactionModel]()
        for tr in transList{
            trans.insert(tr, at: 0)
        }
        return trans
    }
    func delTransaction(_ transaction: TransactionModel){
        do{
            try dbTransaction.write{
                dbTransaction.delete(transaction)
            }
        } catch {
            print("Delete transaction error")
        }
    }
    func changeTransaction(_ transaction: TransactionModel, categ: String, dat: Date, sum: Double, mainSum: Double){
        do{
            try dbTransaction.write{
                transaction.category = categ
                transaction.date = dat
                transaction.amount = sum
                transaction.amountInmainCurrency = mainSum
            }
        } catch {
            print("Change transaction error")
        }
    }
    func hideTrans(_ transaction: TransactionModel, hide: Bool){
        do{
            try dbTransaction.write{
                transaction.hide = hide
            }
        } catch {
            print("Hide transaction error")
        }
    }
 //Cards
    func addCard(card: CardModel){
        do{
            try dbCard.write{
                dbCard.add(card)
            }
        } catch {
            print("Add card error")
        }
    }
    func getCard() -> [CardModel] {
        let cardList = dbCard.objects(CardModel.self)
        var card = [CardModel]()
        for visa in cardList{
            card.append(visa)
        }
        return card
    }
    
    func deleteCard(_ card: CardModel){
            do {
                try dbCard.write {
                    dbCard.delete(card)
                }
            } catch {
                print("Delete card error")
            }
        }
    func changeBalance(_ card: CardModel,
                       addbalance: Double){
        do{
            try dbCard.write{
                card.balance += addbalance
                card.recieveMoney += addbalance
            }
        } catch {
            print("Add money error")
        }
    }
    func spendBalance(_ card: CardModel,
                      spendModey: Double){
        do{
            try dbCard.write{
                card.balance -= spendModey
                card.spendetMoney += spendModey
            }
        } catch {
            print("Spend money error")
        }
    }
}
