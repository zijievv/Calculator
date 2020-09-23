//
//  HistoryView.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-09.
//  Copyright © 2020 zijie vv. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var model: CalculatorModel

    var body: some View {
        VStack {
            if model.totalCount == 0 {
                Text("No History")
            } else {
                Group {
                    HStack {
                        Text("History")
                            .font(.headline)
                        Text("\(model.historyDetail)")
                            .lineLimit(nil)
                    }

                    HStack {
                        Text("Display")
                            .font(.headline)
                        Text("\(model.brain.output)")
                    }

                    Text("Tap to copy result")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 1)
                }

                Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
            }
        }
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(
            model: {
                let calculatorModel = CalculatorModel()
                calculatorModel.apply(.digit(0))
                return calculatorModel
            }()
        )
    }
}
