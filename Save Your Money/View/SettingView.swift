//
//  SetingView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 16.05.2023.
//

import SwiftUI

struct SettingView: View {
    @StateObject var viewModel = SettingViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var showedAlert = false
    @State var showedAddCat = false
    
    var body: some View {
        VStack{
            VStack(spacing: 1){
                HStack{
                    Text("changeMainVal".localized)
                    Picker("", selection: $viewModel.newCurrency) {
                        ForEach(viewModel.picker, id: \.self) { item in
                            Text(item).tag(item)
                                .tint(.black)
                        }
                    }.frame(width: 120, height: 40)
                        .pickerStyle(.wheel)
                }
                Button("accept".localized){
                    withAnimation {
                        showedAlert.toggle()
                    }
                }
                .modifier(ButtonCustom(width: 310, foregroundColor: .black))
            }
            VStack{
                Button("addCategory".localized) {
                    withAnimation {
                        showedAddCat.toggle()
                    }
                }
                .modifier(ButtonCustom(width: 310, foregroundColor: .black))
                List{
                    ForEach(viewModel.category) { category in
                        if !category.hide {
                            Text("\(category.category)".localized)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    if viewModel.category.count > 1{
                                        Button("delete".localized) {
                                            RealmService.shared.hideCategory(category, hide: true)
                                            viewModel.getCategory()
                                        }
                                    }
                                }
                        }
                    }
                }.listStyle(.plain)
            }
            if showedAlert{
                AlertView(showedAlert: $showedAlert)
                    .environmentObject(viewModel)
                    .transition(.slide)
                    .shadow(color: Color("blacked"), radius: 200, x: 6, y: 6)
            }
            if showedAddCat{
                AddCategoryView(showedAddCat: $showedAddCat)
                    .environmentObject(viewModel)
                    .transition(.slide)
                    .shadow(color: Color("blacked"), radius: 200, x: 6, y: 6)
            }
        }
    }
}

//struct SetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
