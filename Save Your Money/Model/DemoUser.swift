//
//  DemoUser.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 19.04.2023.
//

import Foundation
import  RealmSwift
class DemoUser: Object {
    static let user = DemoUser()
    
    
    @Persisted var id: String
    @Persisted var name: String = ""
    @Persisted var pass: String = ""
    @Published var cards: [CardModel] = []

    convenience init(id: String) {
        self.init()
        self.id = UUID().uuidString
    }
}
