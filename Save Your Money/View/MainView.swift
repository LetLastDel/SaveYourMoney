//
//  MainView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 13.04.2023.
//

import SwiftUI
import Charts
struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    @State var showedAddCardView = false
    @State var showedCardView = false
    @State var showedSpendModeyView = false
    @State var showedLogBook = false
    @State var shodewArchieve = false
    @State var showedAlert = false
    @State var showedSetting = false

    @ObservedObject var cards = DataSource.shared
    @AppStorage(PersistedKeys.firstLoad.rawValue) var firstLoad = true
    
    
    var body: some View {
        VStack{
            ScrollView(.horizontal) {
                HStack{
                    Button(action: {
                        showedAddCardView.toggle()
                    }) {
                        VStack(spacing: 0){
                            Image("addCard")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75)
                                .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
                            Text("addCard".localized)
                                .tint(.black)
                        }
                        .fixedSize()
                    }
                    .fullScreenCover(isPresented: $showedAddCardView) {
                        NavigationView {AddCardView()}
                            .environmentObject(viewModel)
                    }
                    ForEach(0 ..< DataSource.shared.card.count, id: \.self) { index in
                        NavigationLink{
                            CardControlView(viewModel: CardControllViewModel(card: DataSource.shared.card[index]), card: DataSource.shared.card[index])
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            VStack(spacing: 0){
                                Image(DataSource.shared.card[index].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75, height: 75)
                                    .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
                                HStack{
                                    Text(String(format: "%.2f", DataSource.shared.card[index].balance))
                                    Text(DataSource.shared.card[index].currency)
                                }
                                .tint(.black)
                                .fixedSize()
                            }
                        }
                    }
                } .padding()
            }.scrollIndicators(.hidden)
            Chart(DataSource.shared.categoriesSum, id: \.id) { tran in
                if tran.name != "addedBal"{
                        BarMark(x: .value("money", tran.value), y: .value("category", tran.name), width: 30)
                            .annotation(position: .trailing,content: {
                                Text( "\(Int(tran.value))")})
                            .annotation(position: .top,alignment: .topLeading,content: {
                                Text( tran.name.localized)})
                            .foregroundStyle(LinearGradient(colors: [.clear, .gray], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(0)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(maxHeight: DataSource.shared.categoriesSum.count <= 4 ? 200 : 400)
            Spacer()
            HStack{
                Text("spent".localized)
                Text("\(String(format: "%.2f" ,DataSource.shared.getTransactionSum))  \(DataSource.shared.currency)")}
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.leading)
            .onTapGesture {
                showedLogBook.toggle()
            }
            
            HStack{
                Button("⚒︎"){
                    showedSetting.toggle()
                }
                .font(.custom("Marker Felt", size: 35))
                .sheet(isPresented: $showedSetting, content: {
                    NavigationView{SettingView()}
                })
                .modifier(ButtonCustom(width: 35, heinght: 35, foregroundColor: .black))
                .bold()
                Spacer()
                Button("≜"){
                    showedLogBook.toggle()
                }
                .font(.custom("Marker Felt", size: 50))
                .sheet(isPresented: $showedSpendModeyView) {
                    NavigationView {SpendMoneyView()}
                        .environmentObject(viewModel)
                }
                .modifier(ButtonCustom(width: 45, heinght: 45, foregroundColor: .black))
                .bold()
                Spacer()
                Button("+") {
                    if viewModel.checkCardDB() {
                        showedSpendModeyView.toggle()
                    }
                }
                .font(.custom("Marker Felt", size: 50))
                .sheet(isPresented: $showedSpendModeyView) {
                    NavigationView {SpendMoneyView()}
                        .environmentObject(viewModel)
                }
                .modifier(ButtonCustom(width: 65, heinght: 65, foregroundColor: .black))
                .bold()
            }
            .padding()
            .font(.system(size: 30))
            
            
        }
            .font(.custom("Marker Felt", size: 12))
            .foregroundColor(.black)
            .onAppear{
                viewModel.getCards()
                DataSource.shared.getTransactions()
                if firstLoad{
                    DataSource.shared.addCategory()
                    firstLoad = false
                }
              //  print(RealmService.shared.config.fileURL)
                DataSource.shared.getGategory()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color("bgCol"))
            .fullScreenCover(isPresented: $showedLogBook) {
                NavigationView {
                    LogBookView()
                }
            }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

