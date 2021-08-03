//
//  ExpressionTests.swift
//  CountOnMeTests
//
//  Created by Gilles David on 23/07/2021.
//

import XCTest

@testable import CountOnMe
class ExpressionTests: XCTestCase {

    var expression: Expression!
    
    override func setUp() {
        super.setUp()
        expression = Expression()
    }

    func testExpression(){
        XCTAssertNotNil(expression)
    }
    
    // success : 1 + 2 = 3.0
    func testGivenInit_WhenAdd1And2_ThenResultIs3(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 + 2"))
        XCTAssertEqual(expression.enterEqual(), express.success("1 + 2 = 3.0"))
    }
    // success : 1 - 2 = 3.0
    func testGivenInit_WhenSoustract1And2_ThenResultIsNegOne(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("-"), express.success("1 - "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 - 2"))
        XCTAssertEqual(expression.enterEqual(), express.success("1 - 2 = -1.0"))
    }
    
    // success : 1 + 2 * 2 + 3 = 3.0
    func testGivenInit_WhenAdd1And2Mul2Add3_ThenResultIsHeight(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 + 2"))
        XCTAssertEqual(expression.enterOperation("*"), express.success("1 + 2 * "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 + 2 * 2"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + 2 * 2 + "))
        XCTAssertEqual(expression.addArg("3"), express.success("1 + 2 * 2 + 3"))
        XCTAssertEqual(expression.enterEqual(), express.success("1 + 2 * 2 + 3 = 8.0"))
    }
    
    // success : 1 + 2 / 4 * 3 + 3 = 5.5
    func testGivenInit_WhenAdd1And2Div4Mul3Add3_ThenResultIsHeight(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 + 2"))
        XCTAssertEqual(expression.enterOperation("/"), express.success("1 + 2 / "))
        XCTAssertEqual(expression.addArg("4"), express.success("1 + 2 / 4"))
        XCTAssertEqual(expression.enterOperation("*"), express.success("1 + 2 / 4 * "))
        XCTAssertEqual(expression.addArg("3"), express.success("1 + 2 / 4 * 3"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + 2 / 4 * 3 + "))
        XCTAssertEqual(expression.addArg("3"), express.success("1 + 2 / 4 * 3 + 3"))
        XCTAssertEqual(expression.enterEqual(), express.success("1 + 2 / 4 * 3 + 3 = 5.5"))
    }
    
    // failure : 0 + *
    func testGivenInit_When0PlusAndMultiply_ThenResultIsFailed(){
        XCTAssertEqual(expression.addArg("0"), express.success("0"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("0 + "))
        XCTAssertEqual(expression.enterOperation("*"), express.failure(.errorExpression))
    }
    
    // Test Divide by zero
    // failure : 5 / 0 =
    func testGivenInit_When5DivideBy0_ThenResultIsFailed(){
        XCTAssertEqual(expression.addArg("5"), express.success("5"))
        XCTAssertEqual(expression.enterOperation("/"), express.success("5 / "))
        XCTAssertEqual(expression.addArg("0"), express.success("5 / 0"))
        XCTAssertEqual(expression.enterEqual(), express.failure(.impossibleDivisionByZero))
    }
    
    // success : 0 reset -> [empty result]
    func testGivenInit_When0AndReset_ThenResultEmpty(){
        XCTAssertEqual(expression.addArg("0"), express.success("0"))
        XCTAssertEqual(expression.reset(), express.success(""))
    }
    
    // Test on Point
    // success . -> 0.
    func testGivenInit_WhenAddPoint_ThenResultZeroPoint(){
        XCTAssertEqual(expression.addPoint(), express.success("0."))
    }
    
    // failure : 1 . . -> error
    func testGivenInit_WhenAddOneAndAddPointAndSecondPoint_ThenResultError(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.addPoint(), express.success("1."))
        XCTAssertEqual(expression.addPoint(), express.failure(.errorOnlyOnePoint))
    }
    
    //success : 1 + . = -> 1 + 0. = 1.0
    func testGivenInit_WhenAddOneAddPlusAndAddPoint_ThenResultError(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + "))
        XCTAssertEqual(expression.addPoint(), express.success("1 + 0."))
        XCTAssertEqual(expression.enterEqual(), express.success("1 + 0. = 1.0"))
    }
    
    // Cancel
    func testGivenInit_WhenAdd1AndPlusAnd2Cancel4_ThenResultEmpty(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 + 2"))
        XCTAssertEqual(expression.cancel(), express.success("1 + "))
        XCTAssertEqual(expression.addArg("3"), express.success("1 + 3"))
        XCTAssertEqual(expression.cancel(), express.success("1 + "))
        XCTAssertEqual(expression.cancel(), express.success("1"))
        XCTAssertEqual(expression.cancel(), express.success(""))
        XCTAssertEqual(expression.cancel(), express.success(""))
    }

}
