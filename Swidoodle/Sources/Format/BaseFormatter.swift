//
//  BaseFormatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseFormatter: Formatter {
    var dateFormat: String = "yyyy-MM-dd HH:mm:ssZ" {
        didSet {
            self.dateFormatter.dateFormat = self.dateFormat
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.dateFormat
        return dateFormatter
    }()
    
    var logFormat: [Format] = [.date, .logLevel, .message, .metadata, .tag]
    
    internal func format(_ content: LogMessage) -> String {
        return self.logFormat.reduce(into: "") { result, formatItem in
            switch formatItem {
            case .date: result += self.format(formattable: Date())
            case .logLevel: result += self.format(formattable: content.logLevel)
            case .message: result += self.format(formattable: content.message)
            case .metadata: result += self.format(formattable: content.metadata)
            case .tag: result += content.tags.map { self.format(formattable: $0) }.description
            case .default(let str): result += self.format(formattable: str)
            }
            result += " "
        }
    }
    
    func format(formattable content: Formattable) -> String {
        switch content {
        case let date as Date: return self.dateFormatter.string(from: date)
        case let logLevel as Logger.LogLevel: return logLevel.description
        case let metadata as Logger.Metadata: return metadata.map{ "\($0.key) = \($0.value.description)" }.description
        case let tag as Logger.Tag: return tag.description
        default: return content.description
        }
    }
}
