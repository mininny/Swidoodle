//
//  BaseLogHandler.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseLogHandler: LogHandler {
    var destinations: [Destination] = []
    
//    var logLevel: Logger.LogLevel
    
    func log(message: @escaping @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata, tags: [Logger.Tag]) {
        self.destinations
            .forEach { $0.log(message: message, logLevel: logLevel, file: file, function: function, line: line, metadata: metadata, tags: tags) }
    }
}
