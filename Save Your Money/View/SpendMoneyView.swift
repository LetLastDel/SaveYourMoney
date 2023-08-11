//
//  SpendMoneyView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import SwiftUI

struct SpendMoneyView: View {
    
    @StateObject var viewModel = SpendModeyViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var mainVal = false

    
    var body: some View {
        VStack{
                Picker("", selection: $viewModel.selectedCat) {
                    ForEach(0 ..< viewModel.category.count, id: \.self) { index in
                        HStack{
                            Text("\(viewModel.category[index].category)".localized)
                                .font(.custom("Marker Felt", size: 12))
                        }.tag(viewModel.category[index])
                    }
                }.pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                Spacer().frame(maxHeight: 30)
                ScrollView(.horizontal) {
                    HStack{
                        Picker("", selection: $viewModel.selectedCard){
                            ForEach( 0 ..< viewModel.card.count, id: \.self) { index in
                                HStack(alignment: .center){
                                    Image(viewModel.card[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 60)
                                        .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
                                    Text(viewModel.card[index].name)
                                        .font(.custom("Marker Felt", size: 12))
                                    Text("\(String(viewModel.card[index].balance))")
                                        .font(.custom("Marker Felt", size: 12))
                                    Text(String(viewModel.card[index].currency))
                                        .font(.custom("Marker Felt", size: 12))
                                }.tag(viewModel.card[index])
                            }
                        }
                        .font(.custom("Marker Felt", size: 12))
                        .pickerStyle(.wheel)
                        .frame(width: 390, height: 80)
                    }
                    .padding(.horizontal, 10)
                }
            VStack{
                TextField("cardVal".localized, text: $viewModel.isertSum)
                    .modifier(TextFieldCustom(text: $viewModel.isertSum, placeholder: "cardVal".localized, imageName: "creditcard", widthSize: 360))
                    ._onBindingChange($viewModel.isertSum) { Value in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                            viewModel.convertToAddition()
                        }
                    }
                    .keyboardType(.numberPad)
                if viewModel.selectedCard.currency != DataSource.shared.currency{

                    TextField("", text: $viewModel.insertMainSum)
                        .modifier(TextFieldCustom(text: $viewModel.insertMainSum, placeholder: "inMainVal".localized, imageName: "creditcard", widthSize: 360))
                        ._onBindingChange($viewModel.insertMainSum) { Value in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                viewModel.convertToMain()
                            }}
                        .keyboardType(.numberPad)
                    
                    HStack{
                        Text("rates".localized)
                        Text("\(viewModel.rates)")
                    }
                }
            }
                DatePicker(selection: $viewModel.date, displayedComponents: .date) {
                }
            Button("accept".localized) {
                    viewModel.spendMoney()
                    viewModel.addTransaction()
                    mainViewModel.getCards()
                    mainViewModel.getTransactions()
                    presentationMode.wrappedValue.dismiss()
                }
                .modifier(ButtonCustom(width: 360, foregroundColor: .black))
            }
            .font(.custom("Marker Felt", size: 12))
            .onChange(of: viewModel.selectedCard, perform: { newValue in
                viewModel.rateRequest()
            })
            .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Image("bg"))
        }
    }

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//struct SpendMoneyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpendMoneyView(, body: some View)
//    }
//}
