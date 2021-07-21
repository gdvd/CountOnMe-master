//
//  Operation.swift
//  CountOnMe
//
//  Created by Gilles David on 21/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation


enum ope {
    case add, sub, mul, div, err
}

struct Operation {
    func define(charac: String) -> ope {
        switch charac{
        case "+":
            return ope.add
        case "-":
            return ope.sub
        case "*":
            return ope.mul
        case "/":
            return ope.div
        default:
            return ope.err
        }
    }
}
