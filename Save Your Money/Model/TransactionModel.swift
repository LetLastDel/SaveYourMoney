//
//  TransactionModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 28.04.2023.
//
import Foundation
import RealmSwift
import SwiftUI

class TransactionModel: Object, Identifiable {
    
    @Persisted var id: String = ""
    @Persisted var image: String = ""
    @Persisted var name: String = ""
    @Persisted var currency: String = ""
    @Persisted var category: String = ""
    @Persisted var amount: Double = 0.0
    @Persisted var amountInmainCurrency: Double = 0.0
    @Persisted var date: Date = Date()
    @Persisted var cardID: String = ""
    @Persisted var rates: Double = 0.0
    @Persisted var hide: Bool = false
    
    
    
    convenience init(image: String, name: String, cardID: String, currency: String, category: String, amount: Double,amountInmainCurrency: Double, date: Date, rates: Double, hide: Bool) {
        self.init()
        self.id = UUID().uuidString
        self.image = image
        self.name = name
        self.cardID = cardID
        self.currency = currency
        self.category = category
        self.amount = amount
        self.amountInmainCurrency = amountInmainCurrency
        self.date = date
        self.rates = rates
        self.hide = hide
    }
}

extension TransactionModel {
    static let transaction: [TransactionModel] = [.init()]
}

