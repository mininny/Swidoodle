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
    
    func test_loggerLogLevel() {
        var logLevels = Logger.LogLevel.allCases
        
        XCTAssertEqual(logLevels.removeFirst().description, "")
        XCTAssertEqual(logLevels.removeFirst().description, "TRACE")
        XCTAssertEqual(logLevels.removeFirst().description, "VERBOSE")
        XCTAssertEqual(logLevels.removeFirst().description, "INFO")
        XCTAssertEqual(logLevels.removeFirst().description, "DEBUG")
        XCTAssertEqual(logLevels.removeFirst().description, "WARNING")
        XCTAssertEqual(logLevels.removeFirst().description, "ERROR")
    }
    
    func test_loggerAddHandler() {
        let destination = TestDestination(logLevel: .trace)
        let logger = Mock.baseLogger(logLevel: .trace)
        
        logger.addHandler(BaseLogHandler(identifier: "testHandler.\(#function)", destinations: [destination]))
            
        logger.debug(message: "Message")
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message")
    }
    
    func test_loggerRemoveHandler() {
        let destination = TestDestination(logLevel: .trace)
        let logger = Mock.baseLogger(logLevel: .trace)
        
        let handler = BaseLogHandler(identifier: "testHandler.\(#function)", destinations: [destination])
        logger.addHandler(handler)
            
        logger.debug(message: "Message")
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message")
        
        logger.removeHandler(handler)
        
        logger.debug(message: "Message")
        
        XCTAssertTrue(destination.output.isEmpty)
        
    }
    
    func test_loggerRemoveHandlerByIdentifier() {
        let destination = TestDestination(logLevel: .trace)
        let logger = Mock.baseLogger(logLevel: .trace)
        
        let handler = BaseLogHandler(identifier: "testHandler.\(#function)", destinations: [destination])
        logger.addHandler(handler)
            
        logger.debug(message: "Message")
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message")
        
        logger.removeHandler(for: "testHandler.\(#function)")
        logger.debug(message: "Message")
        
        XCTAssertTrue(destination.output.isEmpty)
    }
    
    func test_loggerAddHandlerWithExistingIdentifier() {
        let destination = TestDestination(logLevel: .trace)
        let invalidDestination = TestDestination(logLevel: .trace)
        
        let logger = Mock.baseLogger(logLevel: .trace)
        let handler = BaseLogHandler(identifier: "testHandler.\(#function)", destinations: [destination])
        let invalidHandler = BaseLogHandler(identifier: "testHandler.\(#function)", destinations: [destination])
        logger.addHandler(handler)
        
        logger.debug(message: "Message")
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message")
        XCTAssertTrue(invalidDestination.output.isEmpty)
        
        logger.addHandler(invalidHandler)
        
        logger.debug(message: "Message2")
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message2")
        XCTAssertTrue(invalidDestination.output.isEmpty)
    }
    
    func test_createLoggerWithHandlerDictionary() {
        let destination = TestDestination(logLevel: .trace)
        let handler1 = BaseLogHandler(identifier: UUID().uuidString, destinations: [destination])
        let handler2 = BaseLogHandler(identifier: UUID().uuidString, destinations: [destination])
        
        let logger = Logger(logLevel: .trace, handlers: ["handler1": handler1,
                                                         "handler2": handler2])
        
        logger.log(message: "Message1", logLevel: .verbose)
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message1") // from handler 1
        XCTAssertEqual(destination.output.removeFirst().message, "Message1") // from handler 2
        
        logger.removeHandler(for: "handler2")
        
        logger.log(message: "Message2", logLevel: .verbose)
        
        XCTAssertEqual(destination.output.removeFirst().message, "Message2") // from handler 1
        XCTAssertTrue(destination.output.isEmpty) // Handler 2 is removed
    }
}
