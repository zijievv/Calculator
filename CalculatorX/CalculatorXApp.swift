//
//  CalculatorXApp.swift
//  CalculatorX
//
//  Created by zijie vv on 12/10/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
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
