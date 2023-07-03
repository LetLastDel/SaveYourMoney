//
//  ButtonCustom.swift
//  Save Your Money
//
//  Created by A.Stelmakh on 25.04.2023.
//


import SwiftUI

struct ButtonCustom: ViewModifier {
    var width: CGFloat = 360
    var heinght: CGFloat = 50
    var foregroundColor: Color = .black
    

    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color("blacked"), radius: 0, x: 6, y: 6)
                .border(.black, width: 2)
                .frame(width: width, height: heinght)
            content
                .foregroundColor(foregroundColor)
                .font(.custom("Marker Felt", size: 12))
        }
        .padding()
    }
}


