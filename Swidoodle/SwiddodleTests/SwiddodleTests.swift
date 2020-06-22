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
    func test_swidoodle() {
        let logHandler = BaseLogHandler()
        let destination = ConsoleDestination(logLevel: .verbose)
        destination.formatter = BaseFormatter
        logHandler.addDestination(destination)
        
        let logger = Logger(logLevel: .verbose, handlers: [logHandler])
        logger.warning(message: "AHHHHH", metadata: ["asdf": "1234"])
//        Logger.warning(message: 1234, metadata: ["asdf":["asdf", "asdf"], "ddd": "asdfa"], tag: ["NICE", "BAD"])
    }
}
