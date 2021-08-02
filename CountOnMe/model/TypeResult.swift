//
//  Operation.swift
//  CountOnMe
//
//  Created by Gilles David on 21/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

enum expressionError {
    case errorOperator
    case errorExpression
    case impossibleDivisionByZero
    case errorOnlyOnePoint
}
enum express: Equatable {
    case success(String)
    case failure(expressionError)
}
