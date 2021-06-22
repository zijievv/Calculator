//
//  CalculatorButtonItem.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-08.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

protocol CalculatorButtonItemProtocol {
    var imageName: String { get }
    var text: String { get }
    var usingTextSymbol: Bool { get }
}

enum CalculatorButtonItem {
    enum Op: String {
        case plus, minus, multiply, divide, equal
    }

    enum Command: String {
        case clear = "AC"
        case flip = "plus.slash.minus"
        case percent
    }

    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem.Op: CalculatorButtonItemProtocol {
    var usingTextSymbol: Bool { false }
    var imageName: String { self.rawValue }
    var text: String { "" }
}

extension CalculatorButtonItem.Command: CalculatorButtonItemProtocol {
    var usingTextSymbol: Bool {
        switch self {
        case .clear: return true
        default: return false
        }
    }

    var imageName: String {
        switch self {
        case .clear: return ""
        default: return rawValue
        }
    }

    var text: String {
        switch self {
        case .clear: return rawValue
        default: return ""
        }
    }
}

extension CalculatorButtonItem: CalculatorButtonItemProtocol {
    var usingTextSymbol: Bool {
        switch self {
        case .digit(_), .dot: return true
        case let .command(cmd): return cmd.usingTextSymbol
        case let .op(op): return op.usingTextSymbol
        }
    }

    var imageName: String {
        switch self {
        case .dot, .digit(_): return ""
        case let .command(cmd): return cmd.imageName
        case let .op(op): return op.imageName
        }
    }

    var text: String {
        switch self {
        case let .digit(value): return String(value)
        case .dot: return "."
        case let .command(cmd): return cmd.text
        case let .op(op): return op.text
        }
    }
}

extension CalculatorButtonItem {
    var title: String {
        switch self {
        case let .digit(value):
            return String(value)
        case .dot:
            return "."
        case let .op(op):
            switch op {
            case .plus: return "+"
            case .minus: return "-"
            case .multiply: return "×"
            case .divide: return "÷"
            case .equal: return "="
            }
        case let .command(command):
            switch command {
            case .clear: return "<Clear>"
            case .flip: return "<Flip>"
            case .percent: return "%"
            }
        }
    }

    var backgroundColorName: String {
        switch self {
        case .digit, .dot:
            return "digitBackground"
        case .op:
            return"operatorBackground"
        case .command:
            return "commandBackground"
        }
    }
}

extension CalculatorButtonItem: Hashable {}

extension CalculatorButtonItem: CustomStringConvertible {
    var description: String {
        switch self {
        case let .digit(num): return String(num)
        case .dot: return "."
        case let .op(op): return op.rawValue
        case let .command(command): return command.rawValue
        }
    }
}
