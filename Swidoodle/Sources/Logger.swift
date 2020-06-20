//
//  Logger.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

struct Logger {    
    var handlers: [LogHandler] = []
    
    var logLevel: LogLevel = .warning
    
    init(logLevel: LogLevel, handlers: [LogHandler]) {
        self.logLevel = logLevel
        self.handlers = handlers
    }
    
    init() {
        self.init(logLevel: .warning, handlers: [BaseLogHandler()])
    }
    
    internal func log(message: @escaping @autoclosure () -> Any?, logLevel: LogLevel, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        guard logLevel >= self.logLevel else { return }

        self.handlers
            .filter { $0.logLevel >= self.logLevel }
            .forEach { $0.log(message: message,
                                    logLevel: logLevel,
                                    file: file,
                                    function: function,
                                    line: line,
                                    metadata: metadata,
                                    tags: tags) }
    }
    
    func trace(file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.log(message: nil, logLevel: .trace, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    func verbose(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.log(message: message, logLevel: .verbose, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    func info(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.log(message: message, logLevel: .info, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    func debug(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.log(message: message, logLevel: .debug, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    func warning(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.log(message: message, logLevel: .warning, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    func error(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.log(message: message, logLevel: .error, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
}
