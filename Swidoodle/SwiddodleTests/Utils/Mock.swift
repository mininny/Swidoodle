//
//  Mock.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
@testable import Swidoodle

class Mock {
    static func baseLogger(logLevel: Logger.LogLevel, destination: Destination, function: String = #function) -> Logger {
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(function)")
        logHandler.addDestination(destination)
        
        return Logger(logLevel: logLevel, handlers: [logHandler])
    }

    static func baseLogger(logLevel: Logger.LogLevel, function: String = #function) -> Logger {
        let logHandler = BaseLogHandler(identifier: "test.handler.base.\(function)")
        let destination = TestDestination(logLevel: logLevel)
        logHandler.addDestination(destination)
        
        return Logger(logLevel: logLevel, handlers: [logHandler])
    }
}
