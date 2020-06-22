//
//  Destination.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

public protocol Destination {
    var identifier: String { get }
    var logLevel: Logger.LogLevel { get set }
    var queue: DispatchQueue { get set }
    var formatter: Formatter { get set }
    
    func log(message: LogMessage)
}
