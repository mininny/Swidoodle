//
//  LogHandler.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

protocol LogHandler {
    var identifier: String { get }
    var destinations: [Destination] { get set }
    
    func addDestination(_ destination: Destination)
    func removeDestination(_ destination: Destination)
    func log(message: @escaping @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata?, tag: Logger.Tag?)
}
