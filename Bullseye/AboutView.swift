//
//  AboutView.swift
//  Bullseye
//
//  Created by Wiktor Kalaga on 13/11/2021.
//

import SwiftUI

struct AboutView: View {
    
    struct HeadingTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .padding(.top, 20).padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
        }
    }
    
    struct SubHeadingTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .padding(.leading, 60).padding(.trailing, 60).padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
        }
    }
    
    var body: some View {
        Group {
            VStack{
                Text("🎯 Bullseye 🎯").modifier(HeadingTextStyle())
                Text("This is a Bullseye. The game where you can win points and earn fame by dragging a slider.").modifier(SubHeadingTextStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(SubHeadingTextStyle())
                Text("Enjoy 😎!").modifier(SubHeadingTextStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0))
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 844, height: 390))
    }
}
