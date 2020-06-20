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
    public typealias Tag = String
    
    public typealias Metadata = [String: MetaDataValue]
    
    enum MetaDataValue: Formattable {
        var description: String {
            switch self {
            case .string(let string): return string
            case .stringConvertible(let string): return string.description
            case .array(let array): return array.map { $0.description }.joined(separator: ",")
            case .dict(let dict): return dict.map { "\($0): \($1.description)" }.joined(separator: ",")
            }
        }
        
        case string(String)
        case stringConvertible(CustomStringConvertible)
        case array([MetaDataValue])
        case dict([String: MetaDataValue])
    }
    
    enum LogLevel: Int, Comparable, Formattable {
        var description: String {
            switch self {
            case .trace:
                return "[TRACE]"
            case .verbose:
                return "[VERBOSE]"
            case .info:
                return "[INFO]"
            case .debug:
                return "[DEBUG]"
            case .warning:
                return "[WARNING]"
            case .error:
                return "[ERROR]"
            }
        }
        
        static func < (lhs: Logger.LogLevel, rhs: Logger.LogLevel) -> Bool { lhs.rawValue < rhs.rawValue }
        
        case trace
        case verbose
        case info
        case debug
        case warning
        case error
    }
}

extension Logger.MetaDataValue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Logger.MetaDataValue

    public init(arrayLiteral elements: Logger.MetaDataValue...) {
        self = .array(elements)
    }
}

extension Logger.MetaDataValue: ExpressibleByStringInterpolation, ExpressibleByStringLiteral {
    typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

// Extension has to be done on explicit type rather than Logger.Metadata.Value as workaround for
// https://bugs.swift.org/browse/SR-9686
extension Logger.MetaDataValue: ExpressibleByDictionaryLiteral {
    public typealias Key = String
    public typealias Value = Logger.MetaDataValue

    public init(dictionaryLiteral elements: (String, Logger.MetaDataValue)...) {
        self = .dict(.init(uniqueKeysWithValues: elements))
    }
}
