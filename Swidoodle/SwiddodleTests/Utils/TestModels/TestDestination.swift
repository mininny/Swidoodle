//
//  TestDestination.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/07.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
@testable import Swidoodle

class TestDestination: Destination {
    var identifier: String = "com.mininny.swidoodle.test.destination.\(UUID().uuidString)"
    var logLevel: Logger.LogLevel
    
    var queue: DispatchQueue
    
    var formatter: Swidoodle.Formatter
    
    var output: [LogMessage] = []
    
    func log(message: LogMessage) {
        output.append(message)
    }
    
    init(logLevel: Logger.LogLevel, _ formatter: Swidoodle.Formatter = BaseFormatter()) {
        self.logLevel = logLevel
        
        self.formatter = formatter
        self.queue = DispatchQueue(label: "com.mininny.swidoodle.test.destination.queue.\(UUID().uuidString)")
    }
}
