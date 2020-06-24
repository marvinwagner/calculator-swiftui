//
//  ContentView.swift
//  Calculator
//
//  Created by Marvin Wagner on 19/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//

import SwiftUI

class GlobalEnvironment: ObservableObject {
    @Published var displayDescription = " "
    @Published var display = "0"

    var lastNumber = ""
    var lastOperator = ""
    var lastDisplay: String {
        return " \(lastNumber) \(lastOperator)"
    }

    var number: Double = 0.0
    var leftNumber: Double = 0.0

    var calculation: ((Double, Double) -> Double)?

    var clearNextDigit = false

    private func formattedText(_ number: Double) -> String {
        if floor(number) == number {
            return String.init(format: "%0.f", number)
        } else {
            return "\(number)"
        }
    }

    private func calcule() {
        if calculation == nil {
            return
        }

        let result = calculation!(leftNumber, number)
        display = formattedText(result)
        number = result
        clearNextDigit = true
    }

    private func clearCalcule(_ button: CalculatorButton) {
        switch button {
        case .percent:
            number = percent(n1: 0, n2: number)
        case .plusMinus:
            number = plusMinus(n1: 0, n2: number)
        default:
            number = 0
        }
        display = formattedText(number)
    }

    private func setCalcMethod(_ button: CalculatorButton) {
        switch button {
        case .plus:
            calculation = plus
        case .minus:
            calculation = minus
        case .divide:
            calculation = divide
        case .multiply:
            calculation = multiply
        default:
            calculation = nil
        }
        clearNextDigit = true
    }

    private func numberInput(_ button: CalculatorButton) {
        if clearNextDigit {
            clearNextDigit = false
            display = "0"
        }

        if display == "0" {
            if button == .dot {
                number = 0
                display += "."
            } else {
                number = Double(button.title)!
                display = button.title
            }
        } else {
            if button == .dot && display.contains(".") {
                return
            }

            display += button.title
            number = Double(display)!
        }
    }

    func receiveInput(_ button: CalculatorButton) {
        if button.isOperator {
            lastNumber = formattedText(number)
            lastOperator = button.title
            
            if calculation != nil {
                calcule()
            }
            setCalcMethod(button)
            leftNumber = number

            displayDescription += lastDisplay
        } else if button == .equals {
            calcule()
            leftNumber = 0.0
            displayDescription = " "
        } else if button.isNumbers {
            numberInput(button)
        } else if button.isFunction {
            clearCalcule(button)
        } else if button == .delete {
            if display != "0" {
                display.remove(at: display.index(before: display.endIndex))
                if display.count == 0 {
                    display = "0"
                }
                number = Double(display)!
            }
        } else if button == .clear {
            clear(all: false)
        } else if button == .ac {
            clear(all: true)
        }

    }
    
    fileprivate func clear(all: Bool) {
        display = "0"
        number = 0
        if all {
            leftNumber = 0
            clearNextDigit = false
            displayDescription = " "
            calculation = nil
        }
    }

    private func plus(n1: Double, n2: Double) -> Double {
        return n1 + n2
    }

    private func minus(n1: Double, n2: Double) -> Double {
        return n1 - n2
    }

    private func multiply(n1: Double, n2: Double) -> Double {
        return n1 * n2
    }

    private func divide(n1: Double, n2: Double) -> Double {
        return n1 / n2
    }

    private func plusMinus(n1: Double, n2: Double) -> Double {
        return n2 * -1
    }

    private func percent(n1: Double, n2: Double) -> Double {
        return n2 / 100
    }
}
