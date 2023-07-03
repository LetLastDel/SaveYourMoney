//
//  NetworkService.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 11.05.2023.
//

import Foundation
import SwiftUI

struct NetworkService {
    static let shared = NetworkService() ;private init() { }
    
    func getRates(inCurrency: String, outCurrency: String) async throws -> ExchangeModel {
        guard let url = URLManager.shared.createURL(inCurrency: inCurrency, outCurrency: outCurrency) else { throw NetworkError.badUrl}
        do {
            var request = URLRequest(url: url, timeoutInterval: Double.infinity)
            request.httpMethod = "GET"
            request.addValue("YkKGV9M3LdAg5qYR86oLy6dv8bwrNxFk", forHTTPHeaderField: "apikey")
            let data = try await URLSession.shared.data(for: request).0
                let decoder = JSONDecoder()
                let valaue = try decoder.decode(ExchangeModel.self, from: data)
                return valaue
        } catch {
            throw NetworkError.invalidDecoding
        }
    }
}
enum NetworkError: Error {
    case badUrl
    case invalidDecoding
}

    
   
