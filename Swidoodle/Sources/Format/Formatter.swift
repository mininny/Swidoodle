//
//  Formatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

protocol Formatter {
    func format(_ content: LogMessage) -> String
    func format(formattable content: Formattable) -> String
    var dateFormat: String { get set }
    var dateFormatter: DateFormatter { get set }
    var logFormat: [Format] { get set }
}

enum Format: CustomStringConvertible, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    typealias StringLiteralType = String
    init(stringLiteral value: String) {
        if let format = Format(rawValue: value) {
            self = format
        } else {
            self = .default(value: value)
        }
    }
    
    var description: String {
        switch self {
        case .default(let str):
            return str
        default:
            return "_\(self.rawValue)_"
        }
    }
    
    case date
    case logLevel
    case message
    case metadata
    case tag
    case `default`(value: String)
}

extension Format: RawRepresentable  {
    typealias RawValue = String
    public init?(rawValue: RawValue) {
        self = Format.allCases.first(where: { $0.asRaw == rawValue }) ?? .default(value: rawValue)
    }
    
    var asRaw: String? {
        switch self {
        case .date: return "date"
        case .logLevel: return "logLevel"
        case .message: return "message"
        case .metadata: return "metadata"
        case .tag: return "tag"
        case .default: return nil
        }
    }
    
    static var allCases: [Format] = [.logLevel, .message, .metadata, .tag]
    
    public var rawValue: RawValue {
        switch self {
        case .default(let str): return str
        default: return self.asRaw ?? ""
        }
    }
}
