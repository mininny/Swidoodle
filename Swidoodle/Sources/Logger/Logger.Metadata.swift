//
//  Logger.Metadata.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/20.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

extension Logger {
    public typealias Tag = MetadataValue
    
    public typealias Metadata = [String: MetadataValue]
    
    public enum MetadataValue: Formattable {
        public var description: String {
            switch self {
            case .string(let string): return string.description
            case .stringConvertible(let string): return string.description
            case .array(let array): return array.map { $0.description }.joined(separator: ", ")
            case .dict(let dict): return dict.map { "\($0.description): \($1.description)" }.joined(separator: ", ")
            }
        }
        
        case string(String)
        case stringConvertible(CustomStringConvertible)
        case array([MetadataValue])
        case dict([String: MetadataValue])
    }
}

extension Logger.MetadataValue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Logger.MetadataValue

    public init(arrayLiteral elements: Logger.MetadataValue...) {
        self = .array(elements)
    }
}

extension Logger.MetadataValue: ExpressibleByStringInterpolation, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension Logger.MetadataValue: ExpressibleByDictionaryLiteral {
    public typealias Key = String
    public typealias Value = Logger.MetadataValue

    public init(dictionaryLiteral elements: (String, Logger.MetadataValue)...) {
        self = .dict(.init(uniqueKeysWithValues: elements))
    }
}

extension Optional where Wrapped == Logger.Tag {
    var debugDescription: String {
        self?.description ?? ""
    }
}
