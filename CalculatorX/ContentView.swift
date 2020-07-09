//
//  ContentView.swift
//  CalculatorX
//
//  Created by zijie vv on 2020-07-08.
//  Copyright © 2020 zijie vv. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        Spacer()
        Text("0")
          .font(.system(size: geometry.size.width * 0.85 / 4))
          .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
          .padding(.horizontal)
        CalculatorButtonPad(
          size: CGSize(width: geometry.size.width * 0.85 / 4,
                       height: geometry.size.width * 0.85 / 4)
        )
          .padding(.bottom)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
      ContentView().previewDevice("iPhone SE (1st generation)")
      ContentView().previewDevice("iPhone 7 Plus")
    }
  }
}

struct CalculatorButtonPad: View {
  let pad: [[CalculatorButtonItem]] = [
    [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
    [.digit(7), .digit(8), .digit(9), .op(.multiply)],
    [.digit(4), .digit(5), .digit(6), .op(.minus)],
    [.digit(1), .digit(2), .digit(3), .op(.plus)],
    [.digit(0), .dot, .op(.equal)]
  ]
  let size: CGSize
  
  var body: some View {
    VStack(alignment: .trailing) {
      ForEach(pad, id: \.self) { row in
        CalculatorButtonRow(row: row, size: self.size)
      }
    }
  }
}

struct CalculatorButtonRow: View {
  let row: [CalculatorButtonItem]
  let size: CGSize
  
  var body: some View {
    HStack {
      ForEach(row, id: \.self) { item in
        CalculatorButton(
          title: item.title,
          size: self.size,
          backgroundColorName: item.backgroundColorName) {
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
    Button(action: {
      print("Button \(self.title)")
      print(self.size)
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: size.width / 2, style: .circular)
          .frame(width: title != "0" ? size.width : size.width * 2.1, height: size.height)
          .foregroundColor(Color(backgroundColorName))
        Text(title)
          .font(.largeTitle)
          .foregroundColor(.white)
      }
    }
  }
}
