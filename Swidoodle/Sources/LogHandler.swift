//
//  LogHandler.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

protocol LogHandler {
    var destinations: [Destination] { get set }
    
    func log(message: @escaping @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata, tags: [Logger.Tag])
}

extension LogHandler {
    var logLevel: Logger.LogLevel { destinations.map { $0.logLevel }.max() ?? .debug }
}
