//
//  DestinationTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import XCTest
@testable import Swidoodle

class DestinationTests: XCTestCase { }

// OSLogDestinationTest
extension DestinationTests {
    func test_osLogDestination() {
        let destination = OSLogDestination(identifier: self.identifier(), logLevel: .debug)
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        
        logger.debug(message: "Message")
    }
    
    func test_osLogType() {
        var logLevels = Logger.LogLevel.allCases
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, nil)
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, .info)
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, .info)
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, .info)
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, .debug)
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, .error)
        XCTAssertEqual(logLevels.removeFirst().asOSLogType, .fault)
    }
}
