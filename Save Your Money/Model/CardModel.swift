//
//  CardModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 19.04.2023.
//

import Foundation
import RealmSwift

class CardModel: Object {
    
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var balance: Double = 0.0
    @Persisted var currency: String = ""
    @Persisted var image: String = ""
    @Persisted var recieveMoney: Double = 0.0
    @Persisted var spendetMoney: Double = 0.0

    

    convenience init(name: String, balance: Double, currency: String, image: String, recieveMoney: Double, spendetMoney: Double) {
       self.init()
       self.id = UUID().uuidString
       self.name = name
        self.balance = balance
        self.currency = currency
        self.image = image
        self.recieveMoney = recieveMoney
        self.spendetMoney = spendetMoney
    }
}
