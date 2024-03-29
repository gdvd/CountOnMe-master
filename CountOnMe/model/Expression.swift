//
//  Expression.swift
//  CountOnMe
//
//  Created by Gilles David on 21/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit


class Expression {
    
    //MARK:- Expression
    private var exp = String()
    
    //MARK: - Control
    private var canAddOperator: Bool {
        let ele = elements(exp)
        return ele.last != "+" 
            && ele.last != "-" 
            && ele.last != "*" 
            && ele.last != "/"
            && ele.count != 0
    }
    
    private var expressionHaveResult: Bool {
        return exp.firstIndex(of: "=") != nil
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements(exp).count >= 3
    }
    
    private var expressionIsCorrect: Bool {
        let ele = elements(exp)
        return ele.last != "+" 
            && ele.last != "-" 
            && ele.last != "*" 
            && ele.last != "/"
    }
    
    private func expressionHavePoint(_ arg: String) -> Bool {
        return arg.firstIndex(of: ".") != nil
    }
    
    //MARK: - Around expression
    private func elements(_ ele: String) -> [String] {
        return ele.split(separator: " ").map { "\($0)" }
    }
    
    public func reset() -> express {
        exp = ""
        return express.success(exp)
    }
    
    public func cancel() -> express {
        let elements = (exp.split(separator: " ").map { "\($0)" }).dropLast()
        exp = elements.joined(separator: " ")
        if !expressionIsCorrect {exp += " "}
        return express.success(exp)
    }
   
    public func addArg(_ char: String) -> express {
        if expressionHaveResult {
            return express.failure(.errorExpression)
        }
        exp = exp + char
        return express.success(exp)
    }
    
    public func addPoint() -> express {
        if let lastelement = elements(exp).last {
            if canAddOperator {
                if expressionHavePoint(lastelement){
                    return express.failure(.errorOnlyOnePoint)
                } else {
                    exp = exp + "."
                    return express.success(exp)
                }
            }else{
                exp = exp + "0."
                return express.success(exp)
            }
        }else{
            exp = exp + "0."
            return express.success(exp)
        }
    }

    //MARK: - Make operations in expression
    public func enterOperation(_ ope: String) -> express {
        if canAddOperator {
            switch ope {
            case "+":
                exp = exp + " + "
            case "-":
                exp = exp + " - "
            case "*":
                exp = exp + " * "
            case "/":
                exp = exp + " / "
            default:
                return express.failure(.errorExpression)
            }
        } else {
            return express.failure(.errorExpression)
        }
        return express.success(exp)
    }

    //MARK: - Compute expression
    public func enterEqual() -> express {
        if !(expressionIsCorrect && expressionHaveEnoughElement ) {
            return express.failure(.errorExpression)
        }
        
        switch multiplicationAndDivision(elements(exp)){
                    case .failure(let error):
                        return express.failure(error)
                    case .success(let  resultDIvAndMul):
                        switch additionAndSoustraction(elements(resultDIvAndMul)) {
                            case .failure(let error):
                                return express.failure(error)
                            case .success(let  result):
                                exp = exp + " = " + result
                                return express.success(exp)
                        }
                }
    }
    
    //MARK: - Addition & Soustraction
    private func additionAndSoustraction(_ opeToReduce: [String]) -> express {
        var operationsToReduce = opeToReduce
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: result = 0
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        return express.success(operationsToReduce.joined(separator: " "))
    }
     
    //MARK: - Multiplication & Division
    private func multiplicationAndDivision(_ opeToReduce: [String]) -> express {
        var operationsToReduce = opeToReduce
        var position = 1
        while position < operationsToReduce.count && operationsToReduce.count > 1 {
            
            if operationsToReduce[position] ==  "*" || operationsToReduce[position] ==  "/" {
                
                let left = Double(operationsToReduce[position - 1])!
                let operand = operationsToReduce[position]
                let right = Double(operationsToReduce[position + 1])!
                
                var result: Double = 0.0
                switch operand {
                case "*": result = Double(left * right)
                case "/":
                    if right == 0 {
                        return express.failure(.impossibleDivisionByZero)
                    } else {
                        result = Double(left / right)
                    }
                default: break
                }
                // Suppress 3 args
                let indexToDelete = [position - 1, position, position + 1]
                operationsToReduce = operationsToReduce
                    .enumerated()
                    .filter { !indexToDelete.contains($0.offset) }
                    .map { $0.element }
                // Insert result
                operationsToReduce.insert("\(String(format:"%.2f", result))", at: position - 1)
                
            } else {
                position += 2
            }            
        }
        return express.success(operationsToReduce.joined(separator: " "))
    }
}

