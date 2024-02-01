//
//  ContentView.swift
//  Calculator app
//
//  Created by Memory Mhou on 01/02/2024.
//
import SwiftUI

enum Operator: String {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "×"
    case division = "÷"
}

struct ContentView: View {
    @State private var input = ""
    @State private var currentNumber = 0.0
    @State private var selectedOperator: Operator?
    
    let buttons: [[String]] = [
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "-"],
        ["0", ".", "=", "+"]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("\(input)")
                .font(.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(.horizontal, 16)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            Spacer()
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text("\(button)")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .frame(width: self.buttonWidth(button), height: 60)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.clear()
                }) {
                    Text("Clear")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .frame(width: 120, height: 60)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 12)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    func buttonTapped(_ button: String) {
        switch button {
        case "+", "-", "×", "÷":
            if let number = Double(input) {
                currentNumber = number
            }
            selectedOperator = Operator(rawValue: button)
            input = ""
        case "=":
            if let number = Double(input) {
                input = performCalculation(number)
            }
            selectedOperator = nil
        default:
            input += button
        }
    }
    
    func performCalculation(_ number: Double) -> String {
        if let selectedOperator = selectedOperator {
            switch selectedOperator {
            case .addition: return formatResult(currentNumber + number)
            case .subtraction: return formatResult(currentNumber - number)
            case .multiplication: return formatResult(currentNumber * number)
            case .division: return formatResult(currentNumber / number)
            }
        }
        return ""
    }
    
    func formatResult(_ result: Double) -> String {

        let formattedResult = String(format: "%.2f", result)
        return formattedResult.hasSuffix(".00") ? String(format: "%.0f", result) : formattedResult
    }
    
    func buttonWidth(_ button: String) -> CGFloat {
        return button == "0" ? 120 : 60
    }
    
    func clear() {
        input = ""
        currentNumber = 0.0
        selectedOperator = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
