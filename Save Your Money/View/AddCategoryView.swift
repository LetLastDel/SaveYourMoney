//
//  AddCategoryView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 7.05.2023.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject var viewModel = AddCategoryViewModel()
    @EnvironmentObject var settingView: SettingViewModel
    @Binding var showedAddCat: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            VStack{
                TextField("", text: $viewModel.textField)
                    .modifier(TextFieldCustom(text: $viewModel.textField, placeholder: "insertCategory".localized, imageName: "pencil", widthSize: 280))
                Button("add".localized) {
                    viewModel.addCategory()
                    settingView.getCategory()
                    presentationMode.wrappedValue.dismiss()
                    withAnimation {
                        showedAddCat.toggle()
                    }
                }
                .modifier(ButtonCustom(width: 280, foregroundColor: .black))
            }
            .background(.white.opacity(0.3))
            .padding()
        }
        .font(.custom("Marker Felt", size: 12))
        .onTapGesture {
                    UIApplication.shared.endEditing()
                }
        .frame(width: 300)
        .background(.white)
         .border(.black, width: 2)
    }
}
//struct AddCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategoryView(showedAddCat: false)
//    }
//}
