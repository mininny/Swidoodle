//
//  LogMessage.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

struct LogMessage {
    let message: String
    let logLevel: Logger.LogLevel

    let file: String
    let function: String
    let line: UInt
    
    let metadata: Logger.Metadata?
    let tags: [Logger.Tag]?
    
    init(message: String, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata?, tags: [Logger.Tag]?) {
        self.message = message
        self.logLevel = logLevel
        
        self.file = file
        self.function = function
        self.line = line
        
        self.metadata = metadata
        self.tags = tags
    }
}
