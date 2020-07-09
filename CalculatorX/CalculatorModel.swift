//
//  CalculatorModel.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-09.
//  Copyright © 2020 zijie vv. All rights reserved.
//

import Foundation
import Combine

class CalculatorModel: ObservableObject {
  let objectWillChange = PassthroughSubject<Void, Never>()
  
  var brain: CalculatorBrain = .left("0") {
    willSet { objectWillChange.send() }
  }
}
