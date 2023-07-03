//
//  CardControllViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import Foundation


class CardControllViewModel: ObservableObject {
    
    @Published var addBalance: String = ""
    var card: CardModel
    
    init(card: CardModel){
        self.card = card
    }
    func updBalance(){
        RealmService.shared.changeBalance(card, addbalance: Double(addBalance)!)
        addTransaction()
    }
    func addTransaction(){
        let newTransaction = TransactionModel(image: card.image, name: card.name,cardID: card.id, currency: card.currency, category: "addedBal", amount: Double(addBalance)!, amountInmainCurrency: 0, date: Date(), rates: 0, hide: false)
        RealmService.shared.addTransaction(newTransaction)
        DataSource.shared.forGraphical()
    }
        func deleteCard() {
                RealmService.shared.deleteCard(self.card)
    }
}
