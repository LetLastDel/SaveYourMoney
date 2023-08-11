//
//  LogBookViewModel.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 27.04.2023.
//

import Foundation


class LogBookViewModel: ObservableObject{
    private var dataSource = DataSource.shared
    private let today = Date()
    private let calendar = Calendar.current
    
    
    var transaction: [TransactionModel] = []{
        didSet{
            groupByDate()
        }
    }
    @Published var mainCurrency: String = ""
    @Published var groupedByDate = [(date: Date, items: [TransactionModel])]()
    
    init(){
        getTransaction()
    //   groupByDate()
    }
    func getMainCurrency(){
        mainCurrency = dataSource.currency
    }
    func getDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let str = formatter.string(for: date)
        return str!
    }
    func getTime(forIndex index: Int) -> String {
        let date = DataSource.shared.transaction[index].date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        let str = formatter.string(for: date)
        return str!
    }
    func getMonthh(for date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.YYYY"
        let str = formatter.string(for: date)
        return str!
    }
    func getTransaction(){
        transaction = dataSource.transaction
    }
    func forLogBook(for section: (date: Date, items: [TransactionModel])) -> [(id: UUID, name: String, value: Double)] {
        let trans = section.items
        let categories = Set(trans.map{$0.category})
        var categoriesSum = [(id: UUID, name: String, value: Double)]()

        for categor in categories {
            let sum = trans.filter { $0.category == categor }.reduce(0){$0 + $1.amountInmainCurrency}
            let id = UUID()
            let tuple = (id: id, name: categor, value: sum)
            categoriesSum.append(tuple)
        }
        categoriesSum = categoriesSum.sorted { $0.value < $1.value }
        print(categoriesSum)
        return categoriesSum
    }
    func groupByDate() {
        let groupedItems = Dictionary(grouping: transaction) { item in
            Calendar.current.dateComponents([.year, .month], from: item.date)
        }
        let sortedGrouper = groupedItems.map { key, value in
            let date = Calendar.current.date(from: key)!
            return (date: date, items: value)
        }.sorted { $0.date > $1.date }
        self.groupedByDate = sortedGrouper
    }
}
