//
//  TextFieldCustom.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 25.04.2023.
//

import SwiftUI

struct TextFieldCustom: ViewModifier {
    @Binding var text: String
    var placeholder: String
    var imageName: String
    var widthSize: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(.gray)
                .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
                .border(.black, width: 2)
                .frame(width: widthSize, height: 50)
            HStack {
                Image(systemName: imageName)
                TextField(placeholder, text: $text)
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        }.padding()
    }
}


