//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    
    func calculate(_ args: [String]) throws -> String {
        // Check if the input is empty or the first value should be a number
        guard args.count > 0  || args[0].isNumber() else {
            throw CalculatorError.invalidExpression(suggestedFix: "Please provide a valid expression. Eg: 1 + 1")
        }
        
        
        var valueStack: [Int] = [args[0].toInt()]
        
        for i in stride(from: 1, to: args.count, by: 2) {
            let operatorSymbol = args[i]
            let nextValue = args[i + 1]
            
            guard nextValue.isNumber() else {
                throw CalculatorError.invalidExpression(suggestedFix: "Please provide a valid expression. Eg: 1 + 1")
            }
            
            if operatorSymbol.isOperator() {
                if let operation = availableOperations.first(where: { $0.operatorSymbol == operatorSymbol }) {
                    try operation.handle(&valueStack, nextValue.toInt())
                } else {
                    throw CalculatorError.invalidOperator(suggestedFix: "Please provide a valid operator. Eg: +, -, x, /")
                }
            } else {
                throw CalculatorError.invalidOperator(suggestedFix: "Please provide a valid operator. Eg: +, -, x, /")
            }
        }
        
        let result = valueStack.reduce(0, +)
        
        return String(Int(result))
    }
    
    private func sliceQuerySample(_ args: [String], at: Int, samples: Int = 2) -> String {
        let start = max(0, at - samples)
        let end = min(args.count, at + samples)
        return Array(args[start..<end]).joined(separator: " ")
    }
}
