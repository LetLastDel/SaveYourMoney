//
//  MainViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import Foundation

class MainViewModel: ObservableObject {

    func getCards() {
        DataSource.shared.getCardsDB()
    }
    
    func checkCardDB() -> Bool{
        if DataSource.shared.card.isEmpty {
            return false
        } else{
            return true
        }
    }
}
