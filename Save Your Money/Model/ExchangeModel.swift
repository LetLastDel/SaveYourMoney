//
//  ExchangeModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 11.05.2023.
//

import Foundation

struct ExchangeModel:  Decodable {
    var rates: [String :Double]
}
