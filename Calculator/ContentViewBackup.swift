//
//  ContentView.swift
//  Calculator
//
//  Created by Marvin Wagner on 19/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//
//
//import SwiftUI
//
//enum CalculatorButton: String {
//    case zero, one, two, three, four, five, six, seven, eight, nine, dot
//    case equals, plus, minus, multiply, divide
//    case ac, clear, plusMinus, percent
//    case delete
//    
//    var title: String {
//        switch self {
//            case .zero: return "0"
//            case .one: return "1"
//            case .two: return "2"
//            case .three: return "3"
//            case .four: return "4"
//            case .five: return "5"
//            case .six: return "6"
//            case .seven: return "7"
//            case .eight: return "8"
//            case .nine: return "9"
//            case .dot: return "."
//            case .equals: return "="
//            case .minus: return "-"
//            case .plus: return "+"
//            case .divide: return "/"
//            case .multiply: return "x"
//            case .plusMinus: return "+/-"
//            case .percent: return "%"
//            case .clear: return "C"
//        default:
//            return "AC"
//        }
//    }
//    
//    var background: Color {
//        switch self {
//        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
//            return Color(.darkGray)
//        case .ac, .plusMinus, .percent:
//            return Color(.lightGray)
//        default:
//            return .orange
//        }
//    }
//    
//    var isOperator: Bool {
//        switch self {
//        case .plus, .minus, .multiply, .divide:
//            return true
//        default:
//            return false
//        }
//    }
//    
//    var isFunction: Bool {
//        switch self {
//        case .plusMinus, .percent:
//            return true
//        default:
//            return false
//        }
//    }
//    
//    var isNumbers: Bool {
//        switch self {
//        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
//            return true
//        default:
//            return false
//        }
//    }
//}
//
//class GlobalEnvironment: ObservableObject {
//    @Published var displayDescription = " "
//    @Published var display = "0"
//        
//    var lastNumber = ""
//    var lastOperator = ""
//    var lastDisplay: String {
//        return " \(lastNumber) \(lastOperator)"
//    }
//    
//    var number: Double = 0.0
//    var leftNumber: Double = 0.0
//    
//    var calculation: ((Double, Double) -> Double)?
//    
//    var clearNextDigit = false
//    
//    private func formattedText(_ number: Double) -> String {
//        if floor(number) == number {
//            return String.init(format: "%0.f", number)
//        } else {
//            return "\(number)"
//        }
//    }
//    
//    private func calcule() {
//        if calculation == nil {
//            return
//        }
//        
//        let result = calculation!(leftNumber, number)
//        display = formattedText(result)
//        number = result
//        clearNextDigit = true
//    }
//    
//    private func clearCalcule() {
//        calcule()
//        leftNumber = 0.0
//    }
//    
//    private func setCalcMethod(_ button: CalculatorButton) {
//        switch button {
//        case .plus:
//            calculation = plus
//        case .minus:
//            calculation = minus
//        case .divide:
//            calculation = divide
//        case .multiply:
//            calculation = multiply
//        case .plusMinus:
//            calculation = plusMinus
//        case .percent:
//            calculation = percent
//        default:
//            calculation = plus
//        }
//        clearNextDigit = true
//    }
//    
//    private func numberInput(_ button: CalculatorButton) {
//        if clearNextDigit {
//            clearNextDigit = false
//            display = "0"
//        }
//        
//        if display == "0" {
//            if button == .dot {
//                number = 0
//                display += "."
//            } else {
//                number = Double(button.title)!
//                display = button.title
//            }
//        } else {
//            if button == .dot && display.contains(".") {
//                return
//            }
//            
//            display += button.title
//            number = Double(display)!
//        }
//    }
//    
//    func receiveInput(_ button: CalculatorButton) {
//        if button.isOperator {
//            let oldNumber = number
//            if leftNumber > 0 {
//                calcule()
//            }
//            setCalcMethod(button)
//            leftNumber = number
//            print("Antes: \(oldNumber) - depois: \(number)")
//            
//            lastOperator = button.title
//            lastNumber = formattedText(oldNumber)
//            displayDescription += lastDisplay
//        } else if button == .equals {
//            clearCalcule()
//            displayDescription = " "
//        } else if button.isNumbers {
//            numberInput(button)
//        } else if button == .percent {
//            setCalcMethod(button)
//            clearCalcule()
//        } else if button == .plusMinus {
//            setCalcMethod(button)
//            calcule()
//            clearNextDigit = false
//        } else if button == .delete {
//            if display != "0" {
//                display.remove(at: display.index(before: display.endIndex))
//                if display.count == 0 {
//                    display = "0"
//                }
//                number = Double(display)!
//            }
//        } else if button == .clear {
//            number = 0.0
//            display = "0"
//        } else if button == .ac {
//            display = "0"
//            number = 0
//            leftNumber = 0
//            clearNextDigit = false
//            displayDescription = " "
//        }
//        
//    }
//    
//    private func plus(n1: Double, n2: Double) -> Double {
//        return n1 + n2
//    }
//    
//    private func minus(n1: Double, n2: Double) -> Double {
//        return n1 - n2
//    }
//    
//    private func multiply(n1: Double, n2: Double) -> Double {
//        return n1 * n2
//    }
//    
//    private func divide(n1: Double, n2: Double) -> Double {
//        return n1 / n2
//    }
//    
//    private func plusMinus(n1: Double, n2: Double) -> Double {
//        return n2 * -1
//    }
//    
//    private func percent(n1: Double, n2: Double) -> Double {
//        return n2 / 100
//    }
//}
//
//struct ContentView: View {
//    
//    @EnvironmentObject var env: GlobalEnvironment
//    
//    var buttons: [[CalculatorButton]] = [
//        [.ac, .seven, .four, .one, .plusMinus],
//        [.clear, .eight, .five, .two, .zero],
//        [.percent, .nine, .six, .three, .dot],
//        [.divide, .multiply, .minus, .plus, .equals]
//    ]
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            
//            LinearGradient(gradient: Gradient(colors: [Color.init("BackgroundDark"), Color.init("BackgroundLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//                
//            VStack {
//                
//                HStack {
//                    Spacer()
//                    
//                    VStack(alignment: .trailing) {
//                        
//                        Text(self.env.displayDescription)
//                            .foregroundColor(Color("ButtonSecondary"))
//                            .font(.system(size: 26, weight: Font.Weight.light))
//                            
//                        Text(self.env.display)
//                            .foregroundColor(Color("ButtonPrimary"))
//                            .font(.custom("Montserrat-Light", size: 60))
//                            .allowsTightening(true)
//
//                        Button(action: {
//                            self.env.receiveInput(.delete)
//
//                        }) {
//                            Image(systemName: "delete.left")
//                                .aspectRatio(contentMode: .fit)
//                                .foregroundColor(Color("BlueDark"))
//                                .font(.system(size: 30, weight: Font.Weight.light))
//                        }
//                    }
//                }.padding()
//                                
//                HStack(spacing: 0) {
//                    ForEach(buttons, id: \.self) { row in
//                        VStack {
//                            
//                            ForEach(row, id: \.self) { button in
//                                
//                                CalculatorButtonView(button: button, lastRow: row == self.buttons.last)
//                                
//                            }
//                        }
//                        .padding(.bottom)
//                        
//                        .if(row == self.buttons.last) {
//                            $0
//                                .background(LinearGradient(gradient: Gradient(colors: [Color.init("BlueDark"), Color.init("BlueLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                                .edgesIgnoringSafeArea(.bottom))
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct CalculatorButtonView: View {
//    
//    var button: CalculatorButton
//    var lastRow: Bool
//    @Environment(\.verticalSizeClass) var sizeClass
//
//    @EnvironmentObject var env: GlobalEnvironment
//    
//    @ViewBuilder
//    var body: some View {
//            
//        Button(action: {
//            self.env.receiveInput(self.button)
//        }) {
//            Text(self.button.title)
//                .font(.custom("Montserrat-ExtraLight", size: 40))
//            .allowsTightening(true)
//                //.frame(width: self.ButtonWidth(), height: self.ButtonWidth())
//                .frame(minWidth: self.ButtonWidth(), maxWidth: .infinity, maxHeight: (UIScreen.main.bounds.width) / 4)
//                .background(Color.clear)
//                .if(self.button == .ac) {
//                    $0.foregroundColor(Color("BlueDark"))
//                }.if(self.button != .ac) {
//                    $0.foregroundColor(Color("ButtonPrimary"))
//                }
//                    
//        }
//        
//    }
//    
//    fileprivate func ButtonWidth() -> CGFloat {
//        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
//            return (UIScreen.main.bounds.width) / 4
//        } else {
//            return (UIScreen.main.bounds.height) / 4
//        }
//    }
//}
//    
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environmentObject(GlobalEnvironment()).previewDevice("iPad Air 2")
//    }
//}
