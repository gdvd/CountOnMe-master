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
    
    /*
     public func reset()

     public func addArg(_ char: String) -> express

     public func enterOperation(_ ope: String) -> express

     public func enterEqual() -> express
     */

}
