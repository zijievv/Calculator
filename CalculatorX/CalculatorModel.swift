//
//  CalculatorModel.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-09.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import Combine

class CalculatorModel: ObservableObject {
    @Published var brain: CalculatorBrain = .left("0")
    @Published var history: [CalculatorButtonItem] = []

    var temporaryKept: [CalculatorButtonItem] = []

    var historyDetail: String {
        history.map { $0.description }.joined(separator: " ")
    }

    var totalCount: Int {
        history.count + temporaryKept.count
    }

    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }

    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }

    /// Reallocates `history` and `temporaryKept` by `index`.
    /// And reculculates the current state of the `brain`.
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of range")

        let total = history + temporaryKept

        history = Array(total[..<index])
        temporaryKept = Array(total[index...])

        brain = history.reduce(CalculatorBrain.left("0")) {
            result, item in
            result.apply(item: item)
        }
    }
}
