//
//  BaseFormatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

class BaseFormatter: Formatter {
    func format(_ content: LogMessage) -> String {
        let message = "\(content.logLevel.description) \(content.message) \n \(content.metadata.description) \(content.tags.description)"
        return message
    }
    
    private func format(_ content: Formattable) -> String {
        return content.description
    }
}
