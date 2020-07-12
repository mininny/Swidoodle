//
//  LoggerTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import XCTest
@testable import Swidoodle

class LoggerTests: XCTestCase {
    func test_logLevels() {
        let trace = Logger.LogLevel.trace
        let verbose = Logger.LogLevel.verbose
        let info = Logger.LogLevel.info
        let debug = Logger.LogLevel.debug
        let warning = Logger.LogLevel.warning
        let error = Logger.LogLevel.error
        
        let logLevels = [trace, verbose, info, debug, warning, error]
    
        for (index, level) in logLevels.enumerated() {
            for logLevelIndex in 0..<index { XCTAssert(level > logLevels[logLevelIndex]) }
            
            if index != logLevels.count - 1 {
                for logLevelIndex in (index+1)..<logLevels.count { XCTAssert(level < logLevels[logLevelIndex]) }
            }
        }
    }
    
    func test_loggerWithSameLogLevel() {
        let destination = TestDestination(logLevel: .debug)
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        
        logger.trace()
        logger.verbose(message: "Verbose")
        logger.info(message: "Info")
        logger.debug(message: "Debug")
        logger.warning(message: "Warning")
        logger.error(message: "Error")
        
        XCTAssertEqual(destination.output.count, 3)
        XCTAssertEqual(destination.output.removeFirst().message, "Debug")
        XCTAssertEqual(destination.output.removeFirst().message, "Warning")
        XCTAssertEqual(destination.output.removeFirst().message, "Error")
    }
    
    func test_loggerWithHigherDestinationLogLevel() {
        let destination = TestDestination(logLevel: .warning)
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)

        logger.trace()
        logger.verbose(message: "Verbose")
        logger.info(message: "Info")
        logger.debug(message: "Debug")
        logger.warning(message: "Warning")
        logger.error(message: "Error")
        
        XCTAssertEqual(destination.output.count, 2)
        XCTAssertEqual(destination.output.removeFirst().message, "Warning")
        XCTAssertEqual(destination.output.removeFirst().message, "Error")
    }
    
    func test_loggerWithLowerDestinationLogLevel() {
        let destination = TestDestination(logLevel: .verbose)
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        
        logger.trace()
        logger.verbose(message: "Verbose")
        logger.info(message: "Info")
        logger.debug(message: "Debug")
        logger.warning(message: "Warning")
        logger.error(message: "Error")
        
        XCTAssertEqual(destination.output.count, 3)
        XCTAssertEqual(destination.output.removeFirst().message, "Debug")
        XCTAssertEqual(destination.output.removeFirst().message, "Warning")
        XCTAssertEqual(destination.output.removeFirst().message, "Error")
    }
    
    func test_loggerWithFallThroughLoggerLevel() {
        let destination = TestDestination(logLevel: .trace)
        let logger = Mock.baseLogger(logLevel: .fallthrough, destination: destination)
        
        logger.trace()
        logger.verbose(message: "Verbose")
        logger.info(message: "Info")
        logger.debug(message: "Debug")
        logger.warning(message: "Warning")
        logger.error(message: "Error")
        
        XCTAssertEqual(destination.output.count, 6)
        XCTAssertEqual(destination.output.removeFirst().message, "")
        XCTAssertEqual(destination.output.removeFirst().message, "Verbose")
        XCTAssertEqual(destination.output.removeFirst().message, "Info")
        XCTAssertEqual(destination.output.removeFirst().message, "Debug")
        XCTAssertEqual(destination.output.removeFirst().message, "Warning")
        XCTAssertEqual(destination.output.removeFirst().message, "Error")
    }
}
