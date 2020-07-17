//
//  Logger.Static.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/21.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

extension Logger {
    internal static var main = Logger(logLevel: .debug, handlers: [BaseLogHandler(identifier: "com.logger.main.baseHandler", destinations: [ConsoleDestination(identifier: "com.logger.main.console", logLevel: .debug)])])
}

extension Logger {
    public static func trace(file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.main.trace(file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public static func verbose(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.main.verbose(message: message, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    public static func info(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.main.info(message: message, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public static func debug(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.main.debug(message: message, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public static func warning(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.main.warning(message: message, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
    
    public static func error(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tag: Tag? = nil) {
        self.main.error(message: message, file: file, function: function, line: line, metadata: metadata, tag: tag)
    }
}
