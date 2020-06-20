//
//  Logger.Static.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/21.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

extension Logger {
    internal static var main = Logger()
}

extension Logger {
    static func trace(file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]) {
        self.main.trace(file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    static func verbose(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]) {
        self.main.verbose(message: message, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    static func info(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]? = nil) {
        self.main.info(message: message, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    static func debug(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]) {
        self.main.debug(message: message, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    static func warning(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]) {
        self.main.warning(message: message, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
    
    static func error(message: @escaping @autoclosure () -> Any?, file: String = #file, function: String = #function, line: UInt = #line, metadata: Metadata? = nil, tags: [Tag]) {
        self.main.error(message: message, file: file, function: function, line: line, metadata: metadata, tags: tags)
    }
}
