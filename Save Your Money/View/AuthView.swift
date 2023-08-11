//
//  ContentView.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 13.04.2023.
//

import SwiftUI


struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
    @State var isAuth: Bool = true
    @AppStorage(PersistedKeys.firstLoad.rawValue) var firstLoad = true

    
    var body: some View {
        VStack {
            VStack{
                Text("appDesc".localized)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.black)
                    .background(.white.opacity(1)
                        .shadow(ShadowStyle.drop(color: .black, radius: 0 ,x: 6, y: 6)))
            }
            
            .padding()
            VStack(spacing: 1){
                Text("selectVal".localized)
                Picker("", selection: DataSource.shared.$currency) {
                    ForEach(DataSource.shared.pickerArray, id: \.self) { item in
                        Text(item).tag(item)
                            .tint(.black)
                    }
                }.frame(width: 320, height: 40)
                    .pickerStyle(.wheel)
            }
            Button("enter".localized) {
                viewModel.showedMainScreen.toggle()
            }
            .modifier(ButtonCustom(width: 310, foregroundColor: .black))
        }
        .font(.custom("Marker Felt", size: 12))
        .onDisappear{
            DataSource.shared.removeAllTransactions()
            DataSource.shared.removeCategory()
        }
        .onAppear{
            print(RealmService.shared.config.fileURL as Any)
            viewModel.checkFirstLoad()
            if firstLoad{
                DataSource.shared.addCategory()
                firstLoad = false
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Image("bg"))
        .fullScreenCover(isPresented: $viewModel.showedMainScreen) {
            NavigationView { MainView() }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
//}
