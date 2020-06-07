//
//  BaseFormatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseFormatter: Formatter {
    func format(_ content: Formattable) -> String {
        switch content {
        case let logLevel as Logger.LogLevel: return self.logLevel.format(logLevel)
        default: return ""
        }
    }
    
    var logLevel = LogLevel()
    
    struct LogLevel: Formatter {
        func format(_ content: Formattable) -> String {
            guard let logLevel = content as? Logger.LogLevel else { return "" }
            
            switch logLevel {
            case .trace:
                return ""
            case .verbose:
                return verbose
            case .info:
                return ""
            case .debug:
                return ""
            case .warning:
                return ""
            case .error:
                return ""
            }
        }
        
        var verbose = "[verbose]"
    }
}
