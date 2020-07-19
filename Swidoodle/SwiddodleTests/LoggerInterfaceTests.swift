//
//  LoggerInterfaceTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

import Foundation
import XCTest
@testable import Swidoodle

class LoggerInterfaceTests: XCTestCase {
    func test_logger() {
        let destination = TestDestination(logLevel: .trace)
        Logger.main.handlers.first?.value.addDestination(destination)
        Logger.main.logLevel = .trace
        
        Logger.trace()
        Logger.verbose(message: "Verbose")
        Logger.info(message: "Info")
        Logger.debug(message: "Debug")
        Logger.warning(message: "Warning")
        Logger.error(message: "Error")
        
        XCTAssertEqual(destination.output.count, 6)
        XCTAssertEqual(destination.output.removeFirst().message, "")
        XCTAssertEqual(destination.output.removeFirst().message, "Verbose")
        XCTAssertEqual(destination.output.removeFirst().message, "Info")
        XCTAssertEqual(destination.output.removeFirst().message, "Debug")
        XCTAssertEqual(destination.output.removeFirst().message, "Warning")
        XCTAssertEqual(destination.output.removeFirst().message, "Error")
    }
    
    func test_loggerAddDestination() {
        let destination = TestDestination(logLevel: .trace)
        Logger.setLogLevel(.trace)
        Logger.addDestination(destination)
        
        Logger.trace()
        Logger.verbose(message: "Verbose")
        Logger.info(message: "Info")
        Logger.debug(message: "Debug")
        Logger.warning(message: "Warning")
        Logger.error(message: "Error")
        
        XCTAssertEqual(destination.output.count, 6)
        XCTAssertEqual(destination.output.removeFirst().message, "")
        XCTAssertEqual(destination.output.removeFirst().message, "Verbose")
        XCTAssertEqual(destination.output.removeFirst().message, "Info")
        XCTAssertEqual(destination.output.removeFirst().message, "Debug")
        XCTAssertEqual(destination.output.removeFirst().message, "Warning")
        XCTAssertEqual(destination.output.removeFirst().message, "Error")
    }
}
