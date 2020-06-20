//
//  ConsoleDestination.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class ConsoleDestination: Destination {
    var identifier: String = UUID().uuidString
    
    var queue: DispatchQueue
    var logLevel: Logger.LogLevel

    var formatter: Formatter = BaseFormatter()
    
    init(logLevel: Logger.LogLevel, queue: DispatchQueue = .global()) {
        self.logLevel = logLevel
        self.queue = queue
    }
    
    func log(message: LogMessage) {
        print(formatter.format(message))
    }
}
