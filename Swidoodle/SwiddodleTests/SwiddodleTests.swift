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
//        let destination = ConsoleDestination(logLevel: .verbose)
//        logHandler.addDestination(destination)
        let logger = Logger(handlers: ["LOL": logHandler], logLevel: .verbose)
        logger.log(message: "HI", logLevel: .debug, metadata: ["asdf":["asdf", "sdf"], "ddd": "asdfa"], tags: "NICE", "BAD")
    }
}
