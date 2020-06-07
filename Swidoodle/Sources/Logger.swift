//
//  Logger.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

struct Logger {
    var handlers: [String: LogHandler] = [:]
    
    var logLevel: LogLevel = .warning
    
    
    func log(message: @escaping @autoclosure () -> Any?, logLevel: LogLevel, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata, tags: Tag...) {
        guard logLevel >= self.logLevel else { return }
        
        self.handlers
            .filter { $0.value.logLevel >= self.logLevel }
            .forEach { $0.value.log(message: message,
                                    logLevel: logLevel,
                                    file: file,
                                    function: function,
                                    line: line,
                                    metadata: metadata,
                                    tags: tags) }
    }
}

extension Logger {
//    enum Tag { }
    public typealias Tag = String
    
    public typealias Metadata = [String: MetaDataValue]
    
    enum MetaDataValue {
        case string(String)
        case array([MetaDataValue])
        case dict([String: MetaDataValue])
    }
    
    enum LogLevel: Int, Comparable, Formattable {
        static func < (lhs: Logger.LogLevel, rhs: Logger.LogLevel) -> Bool { lhs.rawValue < rhs.rawValue }
        
        case trace
        case verbose
        case info
        case debug
        case warning
        case error
    }
}
