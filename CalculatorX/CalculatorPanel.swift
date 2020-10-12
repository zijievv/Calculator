//
//  CalculatorView.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-08.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//
  

import SwiftUI

struct CalculatorPanel: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .center, spacing: 0) {
                    Spacer()

                    HStack {
                        Text("10")
                            .font(.system(size: 80, weight: .regular, design: .default))
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)
                    }
                    .frame(width: geometry.size.width, alignment: .trailing)

                    CalculatorButtonPad(size: buttonSize(with: geometry))
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                   alignment: .center)
            }
        }
    }

    private func buttonSize(with geometry: GeometryProxy) -> CGSize {
        let side = (geometry.size.width - 16  * 5) / 4
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
                CalculatorButtonRow(row: row, size: self.size)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    //  @Binding var brain: CalculatorBrain
    @EnvironmentObject var model: CalculatorModel
    let row: [CalculatorButtonItem]
    let size: CGSize

    var body: some View {
        HStack(spacing: 16) {
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    title: item.title,
                    size: self.size,
                    backgroundColorName: item.backgroundColorName
                ) {
                    self.model.apply(item)
                    print("Button \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButton: View {
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: size.width / 2, style: .circular)
                    .frame(width: title != "0" ? size.width : size.width * 2 + 16, height: size.height)
                    .foregroundColor(Color(backgroundColorName))
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}
