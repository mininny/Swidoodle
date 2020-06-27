//
//  OSLogDestination.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/23.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import os

@available(iOS 12.0, *)
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
        let formattedMessage = self.formatter.format(message)
        
//        if #available(iOS 14.0, *) {
//            let logger = os.Logger(subsystem: self.identifier, category: message.tag.debugDescription)
//
//            switch message.logLevel {
//            case .fallthrough: break
//            case .trace:
//                logger.trace("\(formattedMessage)")
//            case .verbose:
//                logger.info("\(formattedMessage)")
//            case .info:
//                logger.notice("\(formattedMessage)")
//            case .debug:
//                logger.debug("\(formattedMessage)")
//            case .warning:
//                logger.warning("\(formattedMessage)")
//            case .error:
//                logger.fault("\(formattedMessage)")
//            }
//        } else {
            guard let logType = message.logLevel.asOSLogType else { return }
            
            let osLog = OSLog(subsystem: self.identifier, category: message.tag.debugDescription)
            os_log(logType, log: osLog, "%@ : %@", formattedMessage, (message.metadata ?? [:]))
//        }
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
