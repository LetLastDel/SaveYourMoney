//
//  SettingViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.05.2023.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    @Published var newCurrency: String = "RUB"
    
    func getCategory(){
        DataSource.shared.getGategory()
    }
    func changeCurrentCurrency(){
        DataSource.shared.currency = newCurrency
        DataSource.shared.dropAllTransaction()
    }
}
