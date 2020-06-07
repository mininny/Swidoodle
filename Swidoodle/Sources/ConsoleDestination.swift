//
//  ConsoleDestination.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class ConsoleDestination: Destination {
    var logLevel: Logger.LogLevel
    
    var formatter = BaseFormatter()
    
    init(logLevel: Logger.LogLevel) {
        self.logLevel = logLevel
    }
    
    func log(message: @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata, tags: [Logger.Tag]) {
        guard let message = message() else { return }
        
        var constructed = "\(self.timestamp()): \(formatter.format(logLevel)): \(message)"
        print(constructed)
    }
}
