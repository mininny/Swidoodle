//
//  SwiddodleTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/06/20.
//  Copyright © 2020 Mininny. All rights reserved.
//

import XCTest
@testable import Swidoodle

class SwiddodleTests: XCTestCase {
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
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(#function)")
        let destination = TestDestination(logLevel: .debug)
        logHandler.addDestination(destination)
        
        let logger = Logger(logLevel: .debug, handlers: [logHandler])
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
    
    func test_loggerWithHigherDestinationLevel() {
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(#function)")
        let destination = TestDestination(logLevel: .warning)
        logHandler.addDestination(destination)
        
        let logger = Logger(logLevel: .debug, handlers: [logHandler])
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
    
    func test_loggerWithLowerDestinationLevel() {
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(#function)")
        let destination = TestDestination(logLevel: .verbose)
        logHandler.addDestination(destination)
        
        let logger = Logger(logLevel: .debug, handlers: [logHandler])
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
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(#function)")
        let destination = TestDestination(logLevel: .trace)
        logHandler.addDestination(destination)
        
        let logger = Logger(logLevel: .fallthrough, handlers: [logHandler])
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
    
    func test_formatter() {
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(#function)")
        let formatter = BaseFormatter()
        let destination = TestDestination(logLevel: .verbose, formatter)
        logHandler.addDestination(destination)
        
        
        let logger = Logger(logLevel: .debug, handlers: [logHandler])
        
        let metadata = ["Key": "Item"]
        let message = "Test"
        let tag: Logger.MetadataValue = "Tag"
        
        formatter.logFormat = "[logLevel] message - function:"// metadata, tag"
        logger.debug(message: "Test", metadata: ["Key": "Item"], tag: tag)
        let formattedMessage = destination.formatter.format(destination.output.removeFirst())
        
        XCTAssertEqual(formattedMessage, "[DEBUG] \(message) - \(#function):")
    }
}
