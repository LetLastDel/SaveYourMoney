//
//  SettingViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.05.2023.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    
    private var dataSource = DataSource.shared
    @Published var newCurrency: String = "RUB"
    @Published var picker: [String] = []
    @Published var category: [CategoryModel] = []
    
    init(){
        getPicker()
        getCategory()
    }
    
    func getPicker(){
        picker = dataSource.pickerArray
    }
    
    func getCategory(){
        DataSource.shared.getGategory()
        category = dataSource.category
    }
    func changeCurrentCurrency(){
        DataSource.shared.currency = newCurrency
        DataSource.shared.dropAllTransaction()
    }
}
