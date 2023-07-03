//
//  URLManager.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 26.06.2023.
//

import Foundation

class URLManager {
    static let shared = URLManager(); private init() { }
    
    func createURL(inCurrency: String, outCurrency: String) -> URL? {
        let tunnel = "https://"
        let server = "api.apilayer.com/"
        let endPoint = "exchangerates_data/latest?symbols="
        let adressPart2 = "&base="
        
        let url = tunnel + server + endPoint + inCurrency + adressPart2 + outCurrency
        return URL(string: url)
    }
}
