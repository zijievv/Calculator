//
//  CalculatorXApp.swift
//  CalculatorX
//
//  Created by zijie vv on 23/6/21.
//  Copyright © 2021 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

@main
struct CalculatorXApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorPanel()
                .environmentObject(CalculatorModel())
        }
    }
}
