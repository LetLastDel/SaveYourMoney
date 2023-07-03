//
//  LogBookView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 27.04.2023.
//

import SwiftUI

struct LogBookView: View {
    
    var viewModel = LogBookViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var showAll = false
    
    var body: some View {
        VStack{
            List {
                ForEach(DataSource.shared.groupByDate(), id: \.date) { section in
                    Section(header:Text("\(viewModel.getMonthh(for: section.date))")) {
                        ForEach(section.items) { item in
                            if !item.hide{
                                NavigationLink{
                                    TransactionSettingView(viewModel: TransactionSettingModel(transaction: item), transaction: item)
                                        .environmentObject(viewModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    VStack(alignment: .leading, spacing: 0){
                                        VStack(alignment: .leading, spacing: 0){
                                            HStack{
                                                Image("\(item.image)")
                                                    .resizable()
                                                    .frame(width: 35, height: 20)
                                                Text((item.name))
                                                Spacer()
                                            }.frame(width: 140)
                                            HStack{
                                                Text("\(item.category)".localized)
                                                Spacer()
                                                VStack(alignment: .trailing){
                                                    Text(viewModel.getDate(for: item.date))
                                                }.frame(width: 100)
                                            }
                                        }
                                        HStack{
                                            Text(String(format: "%.2f", item.amount))
                                            Text(item.currency)
                                        }
                                        if item.currency != DataSource.shared.currency{
                                            Text("\(String(format: "%.2f", (item.amountInmainCurrency))) \(DataSource.shared.currency)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    let categorySums = viewModel.forLogBook(for: section)
                    Button("logBookMonth".localized){
                        withAnimation {
                            showAll.toggle()
                        }
                    }
                    if showAll{
                        VStack(alignment: .leading){
                                ForEach(categorySums, id: \.id) { categorySum in
                                    if categorySum.value != 0 {
                                        HStack{
                                            Text("\(categorySum.name.localized) - ")
                                            Text("\(String(format: "%.2f", (categorySum.value)))")
                                            Text("\(DataSource.shared.currency)")
                                        }
                                    }
                                }
                            }
                    }
                }
            }
            
            .listStyle(.plain)
        }
        .padding(.vertical, 30)
        .font(.custom("Marker Felt", size: 12))
        .onAppear{
                DataSource.shared.getTransactions()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .overlay {
                Button("backButton".localized){
                    presentationMode.wrappedValue.dismiss()
                }
                .modifier(ButtonCustom(width: 70, heinght: 25, foregroundColor: .black))
                .offset(x: -140, y: -370)
            }
    }
}

//struct LogBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogBookView()
//    }
//}

