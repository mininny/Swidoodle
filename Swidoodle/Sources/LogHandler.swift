//
//  LogHandler.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

protocol LogHandler {
    var destinations: [Destination] { get set }
    func addDestination(_ destination: Destination)
    var formatter: DateFormatter { get set }
    func log(message: @escaping @autoclosure () -> Any?, logLevel: Logger.LogLevel, file: String, function: String, line: UInt, metadata: Logger.Metadata, tags: [Logger.Tag])
}

extension LogHandler {
    var logLevel: Logger.LogLevel { destinations.map { $0.logLevel }.max() ?? .debug }
    func timestamp() -> String {
        var buffer = [Int8](repeating: 0, count: 255)
        var timestamp = time(nil)
        let localTime = localtime(&timestamp)
        strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S%z", localTime)
        return buffer.withUnsafeBufferPointer {
            $0.withMemoryRebound(to: CChar.self) {
                String(cString: $0.baseAddress!)
            }
        }
    }
}
