//
//  TransactionSetting.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 9.05.2023.
//

import SwiftUI


struct TransactionSettingView: View {
    @StateObject var viewModel: TransactionSettingModel
    @EnvironmentObject var logBookViewmodel: LogBookViewModel
    @EnvironmentObject var mainViewModel: MainViewModel

    var transaction: TransactionModel
    @Environment(\.presentationMode) var presentationMode

    
    
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                Image(transaction.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .padding()
                    .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
                Text("\(transaction.name)")
                    .foregroundColor(.black)
                    .font(.custom("Marker Felt", size: 20))
            }
            if transaction.category != "addedBal".localized{
                VStack(alignment: .center){
                    Picker("", selection: $viewModel.selectedCat) {
                        ForEach(0 ..< viewModel.category.count, id: \.self) { index in
                            HStack{
                                Text(viewModel.category[index].category.localized)
                            }.tag(viewModel.category[index])
                        }
                    }.pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                    TextField("", text: $viewModel.text)
                        .modifier(TextFieldCustom(text: $viewModel.text, placeholder: String(viewModel.transaction.amount), imageName: "person", widthSize: 100))
                        .padding(.horizontal, 150)
                        .offset(x: 65)
                    Text(viewModel.time())
                        .offset(x: 60)
                    DatePicker("", selection: $viewModel.date)
                        .offset(x:-70)
                }
            } else {
                Text("addedBal".localized)
                TextField("", text: $viewModel.text)
                    .modifier(TextFieldCustom(text: $viewModel.text, placeholder: String(viewModel.transaction.amount), imageName: "person", widthSize: 100))
                    .padding(.horizontal, 150)
                    .offset(x: 65)
                Text(viewModel.time())
                    .offset(x: 60)
                DatePicker("", selection: $viewModel.date)
                    .offset(x:-70)
            }
            Button("accept".localized){
                presentationMode.wrappedValue.dismiss()
                viewModel.changeTransaction()
                logBookViewmodel.getTransaction()
                mainViewModel.getTransactions()
            }
            .modifier(ButtonCustom())
            Button("deleteTransaction".localized){
                presentationMode.wrappedValue.dismiss()
                viewModel.hideTrans()
                logBookViewmodel.getTransaction()
                mainViewModel.getTransactions()
            }
            .foregroundColor(.red.opacity(0.7))
        }
        .onAppear{
            viewModel.getCategory()
        }
        .font(.custom("Marker Felt", size: 12))
        .padding()
        .background(Image("bg"))
        .overlay {
            Button("backButton".localized){
                presentationMode.wrappedValue.dismiss()
            }
            .modifier(ButtonCustom(width: 70, heinght: 25, foregroundColor: .black))
            .offset(x: -140, y: -370)
        }
    }
}

//struct TransactionSetting_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionSetting(transaction: TransactionModel(image: "usdCard", name: "Dollar", cardID: "dsf", currency: "USD", category: "Жрать", amount: 120, date: Date()))
//    }
//}
