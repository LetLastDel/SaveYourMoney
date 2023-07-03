//
//  AddCartViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import Foundation

class AddCartViewModel: ObservableObject  {

    @Published var cardName: String = ""
    @Published var cardVal: [String] = ["RUB","USD","EUR", "GEL"]
    @Published var balance: String = ""
    @Published var mainCard: Bool = false
    @Published var name: String = "rubCard"
    @Published var testView: [String] = ["rubCard", "usdCard", "eurCard", "gelCard"]
    var selectedVal: String {
        switch name{
        case "rubCard":
            return "RUB"
        case "usdCard":
            return "USD"
        case "eurCard":
            return "EUR"
        case "gelCard":
            return "GEL"
        default:
           return "RUB"
        }
    }
    
    func addCard() {
       if !cardName.isEmpty{
            let newCard = CardModel(name: cardName, balance: Double(balance) ?? 0, currency: selectedVal, image: name, recieveMoney: 0, spendetMoney: 0)
            RealmService.shared.addCard(card: newCard)
            addTransaction()
        }
    }
    func addTransaction(){
        let newTransaction = TransactionModel(image: name, name: cardName,cardID: "", currency: selectedVal, category: "addedBal", amount: Double(balance) ?? 0, amountInmainCurrency: 0, date: Date(), rates: 0, hide: false)
        RealmService.shared.addTransaction(newTransaction)
    }
}
