//
//  Logger.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

public class Logger {
    var handlers: [String: LogHandler]
    
    var logLevel: LogLevel = .debug
    
    init(logLevel: LogLevel, handlers: [String: LogHandler] = [:]) {
        self.logLevel = logLevel
        self.handlers = handlers
    }
    
    init(logLevel: LogLevel, handlers: [LogHandler] = []) {
        self.logLevel = logLevel
        self.handlers = handlers.reduce(into: [String: LogHandler](), { $0[$1.identifier] = $1 })
    }
    
    internal func log(message: @escaping @autoclosure () -> Any?, logLevel: LogLevel, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        guard logLevel >= self.logLevel else { return }

        self.handlers
            .forEach { $0.value.log(message: message,
                                    logLevel: logLevel,
                                    file: file,
                                    function: function,
                                    line: line,
                                    metadata: metadata,
                                    tag: tag) }
    }
    
    func addHandler(_ handler: LogHandler) {
        guard self.handlers[handler.identifier] == nil else { return }
        
        self.handlers[handler.identifier] = handler
    }
    
    func removeHandler(for identifier: String) {
        self.handlers[identifier] = nil
    }
    
    func removeHandler(_ handler: LogHandler) {
        self.removeHandler(for: handler.identifier)
    }
}

extension Logger {
    public func trace(file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.log(message: nil, logLevel: .trace, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public func verbose(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.log(message: message, logLevel: .verbose, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public func info(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.log(message: message, logLevel: .info, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public func debug(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.log(message: message, logLevel: .debug, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public func warning(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.log(message: message, logLevel: .warning, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public func error(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.log(message: message, logLevel: .error, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
}
