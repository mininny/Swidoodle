//
//  FormatItem.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/21.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

public enum FormatItem {
    var description: String {
        switch self {
        case .default(let str):
            return str
        default:
            return self.rawValue.description
        }
    }
    
    case date
    case logLevel
    case message
    case file
    case function
    case line
    case metadata
    case tag
    case `default`(value: String)
}

extension FormatItem: RawRepresentable  {
    public typealias RawValue = String
    public init(rawValue: RawValue) {
        self = FormatItem.allCases.first(where: { $0.asRaw == rawValue }) ?? .default(value: rawValue)
    }
    
    var asRaw: String {
        switch self {
        case .date: return "date"
        case .logLevel: return "logLevel"
        case .message: return "message"
        case .file: return "file"
        case .function: return "function"
        case .line: return "line"
        case .metadata: return "metadata"
        case .tag: return "tag"
        case .default: return ""
        }
    }
    
    static var allCases: [FormatItem] = [.date, .logLevel, .message, .file, .function, .line, .metadata, .tag]
    
    public var rawValue: RawValue {
        switch self {
        case .default(let str): return str
        default: return self.asRaw
        }
    }
}

extension Array where Element == FormatItem {
    init(fromFormat logFormat: String) {
        var result: [String] = []
        var current = ""
        var isLetter = false
        for char in Array<Character>(logFormat){
            if char.isPunctuation || char.isWhitespace {
                if isLetter == true && current != "" {
                    result.append(current)
                    current = ""
                }
                isLetter = false
            } else {
                if isLetter == false && current != "" {
                    result.append(current)
                    current = ""
                }
                isLetter = true
            }
            current.append(char)
        }
        if current != "" { result.append(current) }
        
        self = result.map({ FormatItem(rawValue: $0) })
    }
}
