//
//  AddCardView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.04.2023.
//

import SwiftUI

struct AddCardView: View {
    
    @StateObject var viewModel = AddCartViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack{
            Text("")
                .padding()
            Picker("", selection: $viewModel.name){
                ForEach($viewModel.testView, id: \.self) { item in
                    Image(item.wrappedValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 400)
                        .rotationEffect(.degrees(-90))
                        .tag(item.wrappedValue)
                }
            }
            .frame(width: 200)
                .labelsHidden()
                .pickerStyle(.wheel)
                .rotationEffect(.degrees(90))
            VStack{
                TextField("insertCardName".localized, text: $viewModel.cardName)
                    .modifier(TextFieldCustom(text: $viewModel.cardName, placeholder: "insertCardName".localized, imageName: "creditcard", widthSize: 360))
                HStack{
                    TextField("insertBalance".localized, text: $viewModel.balance)
                        .modifier(TextFieldCustom(text: $viewModel.balance, placeholder: "insertBalance".localized, imageName: "creditcard", widthSize: 250))
                        .tint(.black)
                        .keyboardType(.numberPad)
                    Text("\(viewModel.selectedVal)")
                        .font(.custom("Marker Felt", size: 22))

                    .frame(width: 100, height: 50)
                    .background(.gray
                        .shadow(ShadowStyle.drop(color: Color("blacked"), radius: 0 ,x: 6, y: 6)))
                    .border(.black, width: 2)
                    .offset(x: -15)
                    .tint(.black)
                }
            }.padding(.vertical)
            Button("accept".localized) {
                viewModel.addCard()
                presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    mainViewModel.getCards()
                }
            }
            .modifier(ButtonCustom(width: 360, foregroundColor: .black))
            Spacer().frame(maxHeight: 10)
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
//struct AddCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCardView()
//    }
//}
