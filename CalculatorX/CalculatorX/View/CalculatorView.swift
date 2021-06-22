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

struct CalculatorView: View {
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()

                Button("History: \(self.model.history.count)") {
                    self.editingHistory = true
                }
                .sheet(isPresented: self.$editingHistory) {
                    HistoryView(model: self.model)
                }

                Text(self.model.brain.output)
                    .font(.system(size: geometry.size.width * 0.85 / 4))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .onLongPressGesture {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = model.brain.output
                    }

                CalculatorButtonPad(
                    size: CGSize(width: geometry.size.width * 0.85 / 4,
                                 height: geometry.size.width * 0.85 / 4)
                )
                .padding(.bottom)
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView()
            //      CalculatorView().previewDevice("iPhone SE (1st generation)")
            //      CalculatorView().previewDevice("iPhone 7 Plus")
        }
    }
}
