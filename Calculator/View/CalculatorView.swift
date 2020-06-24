//
//  ContentView.swift
//  Calculator
//
//  Created by Marvin Wagner on 19/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var buttons: [[CalculatorButton]] = [
        [.ac, .seven, .four, .one, .plusMinus],
        [.clear, .eight, .five, .two, .zero],
        [.percent, .nine, .six, .three, .dot],
        [.divide, .multiply, .minus, .plus, .equals]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            LinearGradient(gradient: Gradient(colors: [Color.init("BackgroundDark"), Color.init("BackgroundLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        
                        Text(self.env.displayDescription)
                            .foregroundColor(Color("ButtonSecondary"))
                            .font(.system(size: 26, weight: Font.Weight.light))
                            
                        Text(self.env.display)
                            .foregroundColor(Color("ButtonPrimary"))
                            .font(.custom("Montserrat-Light", size: 60))
                            .allowsTightening(true)

                        Button(action: {
                            self.env.receiveInput(.delete)

                        }) {
                            Image(systemName: "delete.left")
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("BlueDark"))
                                .font(.system(size: 30, weight: Font.Weight.light))
                        }
                    }
                }.padding()
                                
                HStack(spacing: 0) {
                    ForEach(buttons, id: \.self) { row in
                        VStack {
                            
                            ForEach(row, id: \.self) { button in
                                
                                CalculatorButtonView(button: button, lastRow: row == self.buttons.last)
                                
                            }
                        }
                        .padding(.bottom)
                        
                        .if(row == self.buttons.last) {
                            $0
                                .background(LinearGradient(gradient: Gradient(colors: [Color.init("BlueDark"), Color.init("BlueLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .edgesIgnoringSafeArea(.bottom))
                        }
                    }
                }
            }
        }
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    var lastRow: Bool
    @Environment(\.verticalSizeClass) var sizeClass

    @EnvironmentObject var env: GlobalEnvironment
    
    @ViewBuilder
    var body: some View {
            
        Button(action: {
            self.env.receiveInput(self.button)
        }) {
            Text(self.button.title)
                .font(.custom("Montserrat-ExtraLight", size: 40))
            .allowsTightening(true)
                //.frame(width: self.ButtonWidth(), height: self.ButtonWidth())
                .frame(minWidth: self.ButtonWidth(), maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.width) / 4)
                .background(Color.clear)
                .if(self.button == .ac) {
                    $0.foregroundColor(Color("BlueDark"))
                }.if(self.button != .ac) {
                    $0.foregroundColor(Color("ButtonPrimary"))
                }
                    
        }
        
    }
    
    fileprivate func ButtonWidth() -> CGFloat {
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
            return (UIScreen.main.bounds.width) / 4
        } else {
            return (UIScreen.main.bounds.height) / 4
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView().environmentObject(GlobalEnvironment()).previewDevice("iPad Air 2")
    }
}
