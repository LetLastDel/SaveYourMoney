//
//  AlertView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 17.05.2023.
//

import SwiftUI

struct AlertView: View {
    @EnvironmentObject var settingViewModel: SettingViewModel
    @Binding var showedAlert: Bool
    var body: some View {
        VStack{
            VStack{
                Text("alert".localized)
                    .font(.custom("Marker Felt", size: 25))
                    .padding()
                Text("alertText".localized)
            }
            .font(.custom("Marker Felt", size: 15))
            .padding()
            HStack{
                Button("accept".localized){
                    settingViewModel.changeCurrentCurrency()
                    showedAlert.toggle()
                }
                .modifier(ButtonCustom(width: 100, foregroundColor: .black))
                Button("cancel".localized){
                    withAnimation {
                        showedAlert.toggle()
                    }
                }
                .modifier(ButtonCustom(width: 100, foregroundColor: .black))
            }
        }.frame(width: 300)
        .background(.white)
         .border(.black, width: 2)
    }
}

//struct AlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertView()
//    }
//}
