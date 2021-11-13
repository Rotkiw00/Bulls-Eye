//
//  ContentView.swift
//  Bullseye
//
//  Created by Wiktor Kalaga on 07/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var currentRound = 1
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to: ").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit me!").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("\(alertTitle())"), message: Text("The slider's value is: \(sliderValueRounded()). \n" + "The score you achieved this round: \(pointsForCurrentRound())"), dismissButton: .default(Text("Awesome!")) {
                    self.score += pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.currentRound += 1
                })
            }
            .background(Image("Button")).modifier(Shadow())
            Spacer()
            //Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                    Image("StartOverIcon")
                    Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score: ").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round: ").modifier(LabelStyle())
                Text("\(currentRound)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                    Image("InfoIcon")
                    Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0))
        .navigationBarTitle("Bullseye")
    }
    
    // Useful methods
    func sliderValueRounded() ->  Int {
        return Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        return abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        var bonusPoints = 0
        
        if amountOff() == 0 {
            bonusPoints = (100 - amountOff()) + 100
        } else if amountOff() == 1 {
            bonusPoints = (100 - amountOff()) + 50
        } else {
            bonusPoints = 100 - amountOff()
        }
        return bonusPoints
    }
    
    func alertTitle () -> String {
        let difference = amountOff()
        let title: String
        
        if  difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying ?"
        }
        return title
    }
    
    func startNewGame() {
        target = Int.random(in: 1...100)
        sliderValue = 50.0
        score = 0
        currentRound = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 844, height: 390)) // logical width and logical height iP13
    }
}
