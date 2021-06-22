//
//  CalculatorPanel.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-08.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct CalculatorPanel: View {
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false
    var temp: String = "1234567890"

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 0) {
                    Spacer()

                    Button(action: { editingHistory = true }, label: {
                        Text("History: \(model.history.count)")
                    })
                        .sheet(isPresented: $editingHistory) {
                            HistoryView(model: model)
                        }

                    Text(model.brain.output)
                        .font(.system(size: min(100, 500 / CGFloat(model.brain.output.count)),
                                      weight: .regular,
                                      design: .monospaced))
                        .lineLimit(2)
                        .allowsTightening(true)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: geometry.size.width - 16,
                               minHeight: 0, maxHeight: 100,
                               alignment: .bottomTrailing)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)

                    CalculatorButtonPad(size: buttonSize(with: geometry))
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .center)
            }
        }
    }

    private func buttonSize(with geometry: GeometryProxy) -> CGSize {
        let side = (geometry.size.width - 16 * 5) / 4
        return CGSize(width: side, height: side)
    }
}

struct CalculatorPanel_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorPanel()
    }
}

struct CalculatorButtonPad: View {
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)],
    ]
    let size: CGSize

    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row, size: size)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    @EnvironmentObject var model: CalculatorModel
    let row: [CalculatorButtonItem]
    let size: CGSize

    var body: some View {
        HStack(spacing: 16) {
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    item: item,
                    size: size,
                    backgroundColorName: item.backgroundColorName
                ) {
                    model.apply(item)
                    print("Button \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButton: View {
    let item: CalculatorButtonItem
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: size.width / 2, style: .circular)
                    .frame(width: !isZero ? size.width : size.width * 2 + 16, height: size.height)
                    .foregroundColor(Color(backgroundColorName))

                Group {
                    if item.usingTextSymbol {
                        Text(item.text)
                    } else {
                        Image(systemName: item.imageName)
                    }
                }
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(.white)
            }
        }
    }

    var isZero: Bool {
        switch item {
        case let .digit(value): return value == 0
        default: return false
        }
    }
}
