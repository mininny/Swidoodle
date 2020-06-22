//
//  OSLogDestination.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/23.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import os.log

class OSLogDestination: Destination {
    var identifier: String
    
    var queue: DispatchQueue
    var logLevel: Logger.LogLevel

    var formatter: Formatter = BaseFormatter()
    
    init(identifier: String, logLevel: Logger.LogLevel, queue: DispatchQueue = .global()) {
        self.identifier = identifier
        self.logLevel = logLevel
        self.queue = queue
        
        self.formatter.logFormat = "message - function: line"
    }
    
    func log(message: LogMessage) {
        guard let logType = message.logLevel.asOSLogType else { return }
        
        if let tag = message.tag?.description {
            let osLog = OSLog(subsystem: self.identifier, category: tag)
            os_log(logType, log: osLog, "%@ : %@", message.message, (message.metadata ?? [:]))
        } else {
            os_log(logType, "%@ : %@", message.message, (message.metadata ?? [:]))
        }
    }
}

private extension Logger.LogLevel {
    var asOSLogType: OSLogType? {
        switch self {
        case .fallthrough: return nil
        case .trace, .verbose, .info: return .info
        case .debug: return .debug
        case .warning: return .error
        case .error: return .fault
        }
    }
}
