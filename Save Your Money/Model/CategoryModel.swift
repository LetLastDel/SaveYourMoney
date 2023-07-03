//
//  CategoryModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 4.05.2023.
//

import Foundation
import RealmSwift

class CategoryModel: Object, Identifiable{
    @Persisted var id: String = ""
    @Persisted var category: String = ""
    @Persisted var hide: Bool = false
    
    convenience init(category: String, hide: Bool) {
        self.init()
        self.id = UUID().uuidString
        self.category = category
        self.hide = hide
    }
}
