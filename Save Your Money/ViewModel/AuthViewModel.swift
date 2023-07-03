//
//  AuthViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    
    
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    @Published var selectedPicker: String = ""
    @AppStorage(PersistedKeys.first.rawValue) var first = true
    @Published var showedMainScreen = false

    func checkFirstLoad(){
        if first == true{
            first = false
        } else {
            showedMainScreen.toggle()
        }
    }
}
