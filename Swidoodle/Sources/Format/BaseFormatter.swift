//
//  BaseFormatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseFormatter: Formatter {
    internal lazy var formattedLogItems: [FormatItem] = {
        return [FormatItem](fromFormat: self.logFormat)
    }()
    
    var logFormat: String = "date logLevel message - function: line \n \t metadata, tag" {
        didSet {
            if oldValue != self.logFormat { self.formattedLogItems = [FormatItem](fromFormat: self.logFormat) }
        }
    }
    
    var dateFormat: String = "yyyy-MM-dd HH:mm:ssZ" {
        didSet {
            self.dateFormatter.dateFormat = self.dateFormat
        }
    }
    
    internal lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.dateFormat
        return dateFormatter
    }()
    
    internal func format(_ content: LogMessage) -> String {
        return self.formattedLogItems.reduce(into: "") { result, formatItem in
            switch formatItem {
            case .date: result += self.format(formattable: Date())
            case .logLevel: result += self.format(formattable: content.logLevel)
            case .message: result += self.format(formattable: content.message)
            case .file: result += self.format(formattable: content.file)
            case .function: result += self.format(formattable: content.function)
            case .line: result += self.format(formattable: content.line)
            case .metadata: result += self.format(formattable: content.metadata)
            case .tag: result += content.tags.map { self.format(formattable: $0) }.description
            case .default(let str): result += self.format(formattable: str)
            }
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
