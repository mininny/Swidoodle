//
//  Logger.LogLevel.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/20.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

extension Logger {
    public enum LogLevel: Int, Comparable, Formattable {
        public var description: String {
            switch self {
            case .fallthrough:
                return ""
            case .trace:
                return "TRACE"
            case .verbose:
                return "VERBOSE"
            case .info:
                return "INFO"
            case .debug:
                return "DEBUG"
            case .warning:
                return "WARNING"
            case .error:
                return "ERROR"
            }
        }
        
        public static func < (lhs: Logger.LogLevel, rhs: Logger.LogLevel) -> Bool { lhs.rawValue < rhs.rawValue }
        
        case `fallthrough`
        case trace
        case verbose
        case info
        case debug
        case warning
        case error
    }
}
