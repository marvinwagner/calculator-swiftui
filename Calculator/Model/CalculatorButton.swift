//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Marvin Wagner on 23/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine, dot
    case equals, plus, minus, multiply, divide
    case ac, clear, plusMinus, percent
    case delete
    
    var title: String {
        switch self {
            case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .dot: return "."
            case .equals: return "="
            case .minus: return "-"
            case .plus: return "+"
            case .divide: return "/"
            case .multiply: return "x"
            case .plusMinus: return "+/-"
            case .percent: return "%"
            case .clear: return "C"
        default:
            return "AC"
        }
    }
    
    var background: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
    var isOperator: Bool {
        switch self {
        case .plus, .minus, .multiply, .divide:
            return true
        default:
            return false
        }
    }
    
    var isFunction: Bool {
        switch self {
        case .plusMinus, .percent:
            return true
        default:
            return false
        }
    }
    
    var isNumbers: Bool {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
            return true
        default:
            return false
        }
    }
}
