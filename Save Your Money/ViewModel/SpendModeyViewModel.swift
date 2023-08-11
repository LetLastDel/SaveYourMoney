//
//  SpendModeyViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import Foundation

class SpendModeyViewModel: ObservableObject {
    
    private var dataSource = DataSource.shared
    @Published var card: [CardModel] = []
    @Published var category: [CategoryModel] = []  
    @Published var selectedCat = CategoryModel()
    @Published var selectedCard = CardModel()
    @Published var isertSum: String = ""
    @Published var insertMainSum: String = ""
    @Published var date: Date = Date()
    @Published var currency: String = ""
    @Published var rates: String = ""
    @Published var rateForTransaction: String = ""
    @Published var mainCurrency: String = ""
    
    init(){
        getCategories()
        getCards()
        rateRequest()
        mainCurrency = dataSource.currency

    }
    func getCards(){
        dataSource.getCardsDB()
        card = dataSource.card
        selectedCard = card[0]
    }
    func getCategories(){
        dataSource.getGategory()
        category = dataSource.category
        selectedCat = category[0]
    }
    func convertToMain(){
        if !insertMainSum.isEmpty{
        let a = (Double(insertMainSum) ?? 0) * (Double(rates) ?? 1)
        self.isertSum = String(format: "%.2f", a)
        }
    }
    func convertToAddition(){
        if !isertSum.isEmpty{
            let a = (Double(isertSum) ?? 0)  / Double(rates)!
            self.insertMainSum = String(format: "%.2f", a)
       }
    }
    func spendMoney(){
        RealmService.shared.spendBalance(selectedCard, spendModey: ((Double(isertSum) ?? 0)))
    }
    func addTransaction(){
        if !isertSum.isEmpty{
            let newTransaction = TransactionModel(image: selectedCard.image,
                                                  name: selectedCard.name,cardID: selectedCard.id,
                                                  currency: selectedCard.currency,
                                                  category: selectedCat.category,
                                                  amount: Double(isertSum)!,
                                                  amountInmainCurrency: Double(isertSum)! / (Double(rates) ?? 1),
                                                  date: date,
                                                  rates: Double(rates) ?? 1,
                                                  hide: false)
            RealmService.shared.addTransaction(newTransaction)
        }
    }
    func rateRequest(){
        rateForTransaction = selectedCard.currency
        if rateForTransaction != DataSource.shared.currency{
            Task {
                do {
                    let rate = try await NetworkService.shared.getRates(inCurrency: rateForTransaction, outCurrency: dataSource.currency)
                    DispatchQueue.main.async {
                        self.rates = String(rate.rates.values.first!)
                    }
                } catch {
                    print(error)
                }
            }
        } else {
            self.rates = String("1")
        }
    }
}

