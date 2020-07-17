//
//  LogHandlerTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import XCTest
@testable import Swidoodle

class LogHandlerTests: XCTestCase {
    func test_baseLogHandler() {
        let logHandler = BaseLogHandler(identifier: "com.mininny.swidoodle.test.loghandler.baseloghandler")
        let destination = TestDestination(logLevel: .verbose)
        logHandler.addDestination(destination)
        
        logHandler.log(message: "Message", logLevel: .verbose, file: "", function: "", line: 0, metadata: nil, tag: nil)
        
        XCTAssert(destination.output.removeFirst().message == "Message")
        
        logHandler.removeDestination(destination)
        logHandler.log(message: "Message", logLevel: .verbose, file: "", function: "", line: 0, metadata: nil, tag: nil)
        
        XCTAssertTrue(destination.output.isEmpty)
    }
    
    func test_baseLogHandlerRemoveDestinationByIdentifier() {
      let logHandler = BaseLogHandler(identifier: "com.mininny.swidoodle.test.loghandler.baseloghandler")
        let destination = TestDestination(logLevel: .verbose)
        logHandler.addDestination(destination)
        
        logHandler.log(message: "Message", logLevel: .verbose, file: "", function: "", line: 0, metadata: nil, tag: nil)
        
        XCTAssert(destination.output.removeFirst().message == "Message")
        
        logHandler.removeDestination(for: destination.identifier)
        logHandler.log(message: "Message", logLevel: .verbose, file: "", function: "", line: 0, metadata: nil, tag: nil)
        
        XCTAssertTrue(destination.output.isEmpty)
    }
    
}
