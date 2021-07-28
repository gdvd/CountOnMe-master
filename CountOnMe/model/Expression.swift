//
//  Expression.swift
//  CountOnMe
//
//  Created by Gilles David on 21/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit


class Expression {
    private var exp = String()
    
    private var canAddOperator: Bool {
        return exp.last?.description != "+" 
            && exp.last?.description != "-" 
            && exp.last?.description != "*" 
            && exp.last?.description != "/"
    }
    
    private var expressionHaveResult: Bool {
        return exp.firstIndex(of: "=") != nil
    }
    
    private func expressionToString() -> String {
        return exp
    }
    
    var expressionIsCorrect: Bool {
        return exp.last != "+" 
            && exp.last != "-" 
            && exp.last != "*" 
            && exp.last != "/"
    }
    
    private func verifElement(_ char: String) -> Bool{
        return false
    }
    
    public func addArg(_ char: String) -> String {
        if expressionHaveResult {
            return ""
        }
        return exp + char
    }

    public func enterOperation(_ ope: String) -> String? {
        if canAddOperator {
            switch ope {
            case "+":
                exp = exp + " +"
            case "-":
                exp = exp + " - "
            case "*":
                exp = exp + " * "
            case "/":
                exp = exp + " / "
            default:
                print("Error : invalid operator")
            }
        } else {
            return nil
        }
        if expressionHaveResult {
            exp = ""
        }
        return exp
    }
    public func enterEqual(_ ope: String) -> String? {
        /*
         guard expressionIsCorrect else {
             let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
             alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
             return self.present(alertVC, animated: true, completion: nil)
         }
         
         guard expressionHaveEnoughElement else {
             let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
             alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
             return self.present(alertVC, animated: true, completion: nil)
         }
         
         // Create local copy of operations
         var operationsToReduce = elements
         
         // Iterate over operations while an operand still here
         while operationsToReduce.count > 1 {
             let left = Int(operationsToReduce[0])!
             let operand = operationsToReduce[1]
             let right = Int(operationsToReduce[2])!
             
             let result: Int
             switch operand {
             case "+": result = left + right
             case "-": result = left - right
             default: fatalError("Unknown operator !")
             }
             
             operationsToReduce = Array(operationsToReduce.dropFirst(3))
             operationsToReduce.insert("\(result)", at: 0)
         }
         
         textView.text.append(" = \(operationsToReduce.first!)")
         */
        return nil
    }
}
