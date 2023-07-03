//
//  AddAlertViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 7.05.2023.
//

import Foundation

class AddCategoryViewModel: ObservableObject {
    @Published var textField = ""
    
    func addCategory(){
        let cat: CategoryModel = CategoryModel(category: textField, hide: false)
        RealmService.shared.addCategory(cat)
        DataSource.shared.getGategory()
    }
}
