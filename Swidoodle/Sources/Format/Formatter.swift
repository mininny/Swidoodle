//
//  Formatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

public protocol Formatter {
    var dateFormat: String { get set }
    var dateFormatter: DateFormatter { get set }
    var logFormat: String { get set }
    var formattedLogItems: [FormatItem] { get }
    
    func format(_ content: LogMessage) -> String
    func format(formattable content: Formattable?) -> String
}
