//
//  CardControlView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import SwiftUI

struct CardControlView: View {
    
    @ObservedObject var viewModel: CardControllViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var authModel = AuthViewModel()

    var card: CardModel
    
    var body: some View {
        VStack{
            Text("\(viewModel.card.name)")
                .padding()
            Image("\(viewModel.card.image)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .padding()
                .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
            HStack{
                Text("balanceNow".localized)
                Text("\(String(format: "%.3f" ,viewModel.card.balance))")
                Text("\(viewModel.card.currency)")
            }
                TextField("", text: $viewModel.addBalance)
                .modifier(TextFieldCustom(text: $viewModel.addBalance, placeholder: "addBalance".localized, imageName: "creditcard", widthSize: 360))
            Spacer().frame(maxHeight: 150)
            Button("accept".localized) {
                viewModel.updBalance()
                mainViewModel.getCards()
                presentationMode.wrappedValue.dismiss()
            }
            .modifier(ButtonCustom(width: 360, foregroundColor: .black))
            Spacer().frame(maxHeight: 30)
            Spacer()
            Button("deleteCard".localized){
                presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    viewModel.deleteCard()
                    mainViewModel.getCards()
                }
            }
            .foregroundColor(.red.opacity(0.7))
        }
        .font(.custom("Marker Felt", size: 12))
        .onTapGesture {
                    UIApplication.shared.endEditing()
                }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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

//struct CardControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardControlView(viewModel: CardControllViewModel(card: CardModel(name: "", balance: 332, currency: "", image: "", recieveMoney: 1, spendetMoney: 1)), card: CardModel())
//    }
//}
