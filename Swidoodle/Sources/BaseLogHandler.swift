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
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat =
        return dateFormatter
    }()
    
    func addDestination(_ destination: Destination) {
        self.destinations.append(destination)
    }
    func log(message: @escaping @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata, tags: [Logger.Tag]) {
        guard let content = message() else { return }
        let message = LogMessage(
            message: "\(content)",
            logLevel: logLevel,
            file: file,
            function: function,
            line: line,
            metadata: metadata,
            tags: tags
        )
        
        self.destinations.filter({ $0.logLevel < logLevel }).forEach({ $0.log(message: message) })
//        self.destinations.forEach { $0.log(message: message, logLevel: logLevel, file: file, function: function, line: line, metadata: metadata, tags: tags) }
    }
}
