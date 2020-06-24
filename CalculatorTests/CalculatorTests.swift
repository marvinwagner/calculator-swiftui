//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Marvin Wagner on 22/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    var calc: GlobalEnvironment!

    override func setUpWithError() throws {
        calc = GlobalEnvironment()
    }

    override func tearDownWithError() throws {
        calc = nil
        super.tearDown()
    }

    //MARK: - Simple calculations
    
    func testPlusCalculation() throws {
        calc.receiveInput(.two)
        calc.receiveInput(.plus)
        calc.receiveInput(.three)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "2 +")
        
        calc.receiveInput(.equals)
        XCTAssertEqual(calc.display, "5")
    }
    
    func testMinusCalculation() throws {
        calc.receiveInput(.two)
        calc.receiveInput(.minus)
        calc.receiveInput(.three)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "2 -")
        
        calc.receiveInput(.equals)
        XCTAssertEqual(calc.display, "-1")
    }
    
    func testMultiplyCalculation() throws {
        calc.receiveInput(.two)
        calc.receiveInput(.multiply)
        calc.receiveInput(.three)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "2 x")
        
        calc.receiveInput(.equals)
        XCTAssertEqual(calc.display, "6")
    }
    
    func testDivideCalculation() throws {
        calc.receiveInput(.seven)
        calc.receiveInput(.divide)
        calc.receiveInput(.two)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "7 /")
        
        calc.receiveInput(.equals)
        XCTAssertEqual(calc.display, "3.5")
    }
    
    func testMultipleCalculation() throws {
        calc.receiveInput(.two)
        calc.receiveInput(.plus)
        calc.receiveInput(.three)
        calc.receiveInput(.minus)
        calc.receiveInput(.one)
        calc.receiveInput(.multiply)
        calc.receiveInput(.one)
        calc.receiveInput(.zero)
        calc.receiveInput(.divide)
        calc.receiveInput(.two)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "2 + 3 - 1 x 10 /")
        
        calc.receiveInput(.equals)
        XCTAssertEqual(calc.display, "20")
    }

    //MARK: - Functions
    
    func testPercent() throws {
        calc.receiveInput(.two)
        calc.receiveInput(.five)
        calc.receiveInput(.percent)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "")
        XCTAssertEqual(calc.display, "0.25")
    }
    
    func testPlusMinus() throws {
        calc.receiveInput(.three)
        calc.receiveInput(.plus)
        calc.receiveInput(.two)
        calc.receiveInput(.five)
        calc.receiveInput(.plusMinus)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "3 +")
        XCTAssertEqual(calc.display, "-25")
    }
    
    func testPercentAndOperator() throws {
        calc.receiveInput(.one)
        calc.receiveInput(.two)
        calc.receiveInput(.plus)
        calc.receiveInput(.two)
        calc.receiveInput(.two)
        calc.receiveInput(.two)
        calc.receiveInput(.two)
        calc.receiveInput(.percent)
        calc.receiveInput(.plus)
        calc.receiveInput(.one)
        calc.receiveInput(.zero)
        calc.receiveInput(.zero)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "12 + 22.22 +")
        
        calc.receiveInput(.equals)
        XCTAssertEqual(calc.display, "134.22")
    }
    
    func testDelete() throws {
        calc.receiveInput(.three)
        calc.receiveInput(.four)
        calc.receiveInput(.five)
        calc.receiveInput(.six)
        calc.receiveInput(.delete)
        calc.receiveInput(.delete)
        XCTAssertEqual(calc.display, "34")
    }
    
    func testDeleteAll() throws {
        calc.receiveInput(.three)
        calc.receiveInput(.four)
        calc.receiveInput(.five)
        calc.receiveInput(.six)
        calc.receiveInput(.delete)
        calc.receiveInput(.delete)
        calc.receiveInput(.delete)
        calc.receiveInput(.delete)
        calc.receiveInput(.delete)
        XCTAssertEqual(calc.display, "0")
    }
    
    func testClearNumber() throws {
        calc.receiveInput(.three)
        calc.receiveInput(.four)
        calc.receiveInput(.plus)
        calc.receiveInput(.six)
        calc.receiveInput(.six)
        calc.receiveInput(.clear)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "34 +")
        XCTAssertEqual(calc.display, "0")
        
        calc.receiveInput(.five)
        calc.receiveInput(.two)
        XCTAssertEqual(calc.display, "52")
    }
    
    func testClearCalculator() throws {
        calc.receiveInput(.three)
        calc.receiveInput(.four)
        calc.receiveInput(.plus)
        calc.receiveInput(.six)
        calc.receiveInput(.six)
        calc.receiveInput(.ac)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "")
        XCTAssertEqual(calc.display, "0")
        
        calc.receiveInput(.five)
        calc.receiveInput(.plus)
        calc.receiveInput(.two)
        XCTAssertEqual(calc.displayDescription.trimmingCharacters(in: .whitespacesAndNewlines), "5 +")
        XCTAssertEqual(calc.display, "2")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {            
            // Put the code you want to measure the time of here.
        }
    }

}
