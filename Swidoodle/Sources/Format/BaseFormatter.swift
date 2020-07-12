//
//  BaseFormatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseFormatter: Formatter {
    var substituteEmpty: Bool
    
    init(substituteEmpty: Bool) {
        self.substituteEmpty = substituteEmpty
    }
    
    convenience init() {
        self.init(substituteEmpty: false)
    }

    internal lazy var formattedLogItems: [FormatItem] = {
        return [FormatItem](fromFormat: self.logFormat)
    }()
    
    var logFormat: String = "date [logLevel] message - function: line \n \t metadata, tag" {
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
            var formattedItem: String
            
            switch formatItem {
            case .date:
                formattedItem = self.format(formattable: Date())
            case .logLevel:
                formattedItem = self.format(formattable: content.logLevel)
            case .message:
                formattedItem = self.format(formattable: content.message)
            case .file:
                formattedItem = self.format(formattable: content.file)
            case .function:
                formattedItem = self.format(formattable: content.function)
            case .line:
                formattedItem = self.format(formattable: content.line)
            case .metadata:
                formattedItem = self.format(formattable: content.metadata)
            case .tag:
                formattedItem = self.format(formattable: content.tag)
            case .default(let str):
                formattedItem = self.format(formattable: str)
            }
            
            result.append(formattedItem, self.substituteEmpty)
        }.trimmingCharacters(in: .whitespacesAndNewlines)//.init(charactersIn: " ,:;-=~[{\\\n\t"))
    }
    
    func format(formattable content: Formattable?) -> String {
        switch content {
        case let date as Date:
            return self.dateFormatter.string(from: date)
        
        case let logLevel as Logger.LogLevel:
            return logLevel.description
        
        case let metadata as Logger.Metadata:
            return metadata.description
        
        case let tag as Logger.Tag:
            return tag.description
        
        default:
            return content?.description ?? ""
        }
    }
}

fileprivate extension String {
    mutating func append(_ string: String, _ substituteEmpty: Bool) {
        if string == "" && substituteEmpty { self.append("<Empty>") }
        else { self.append(string) }
    }
}
 
