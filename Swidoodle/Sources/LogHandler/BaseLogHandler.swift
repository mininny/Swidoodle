//
//  BaseLogHandler.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseLogHandler: LogHandler {
    var identifier: String
    
    var destinations: [Destination]
        
    init(identifier: String, destinations: [Destination] = []) {
        self.identifier = identifier
        self.destinations = destinations
    }
    
    func addDestination(_ destination: Destination) {
        if !self.destinations.contains(where: { $0.identifier == destination.identifier }) {
            self.destinations.append(destination)
        }
    }
    
    func removeDestination(for identifier: String) {
        self.destinations.removeAll(where: { $0.identifier == identifier })
    }
    
    func removeDestination(_ destination: Destination) {
        self.removeDestination(for: destination.identifier)
    }
    
    func log(message: @escaping @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata?, tag: Logger.Tag?) {
        guard let content = message() else { return }
        let message = LogMessage(
            message: "\(content)",
            logLevel: logLevel,
            file: file,
            function: function,
            line: line,
            metadata: metadata,
            tag: tag
        )
        
        self.destinations
            .filter { logLevel >= $0.logLevel }
            .forEach { $0.log(message: message) }
    }
}
