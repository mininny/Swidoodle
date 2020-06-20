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
    
    func log(message: LogMessage) {
        print(formatter.format(message))
    }
}
