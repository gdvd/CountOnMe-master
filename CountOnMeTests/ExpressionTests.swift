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
    
    func testGivenInit_WhenAdd1And2_ThenResultIs3(){
        XCTAssertEqual(expression.addArg("1"), express.success("1"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("1 + "))
        XCTAssertEqual(expression.addArg("2"), express.success("1 + 2"))
        XCTAssertEqual(expression.enterEqual(), express.success("3.0"))
    }
    
    func testGivenInit_When0PlusAndMultiply_ThenResultIsFailed(){
        XCTAssertEqual(expression.addArg("0"), express.success("0"))
        XCTAssertEqual(expression.enterOperation("+"), express.success("0 + "))
        XCTAssertEqual(expression.enterOperation("*"), express.failure(.errorExpression))
    }
    
    func testGivenInit_When5DivideBy0_ThenResultIsFailed(){
        XCTAssertEqual(expression.addArg("5"), express.success("5"))
        XCTAssertEqual(expression.enterOperation("/"), express.success("5 / "))
        XCTAssertEqual(expression.addArg("0"), express.success("5 / 0"))
        XCTAssertEqual(expression.enterEqual(), express.failure(.impossibleDivisionByZero))
    }
    
    func testGivenInit_When0AndReset_ThenResultEmpty(){
        XCTAssertEqual(expression.addArg("0"), express.success("0"))
        expression.reset()
        XCTAssertEqual(expression.exp, "")
    }

}
