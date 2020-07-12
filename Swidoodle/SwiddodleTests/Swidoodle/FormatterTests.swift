//
//  FormatterTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import XCTest
@testable import Swidoodle

class FormatterTests: XCTestCase {
    func test_formatItem() {
        var formatItems: [FormatItem] = .init(fromFormat: "date, logLevel, message, file, function, line, metadata, tag, default")
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.date)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.logLevel)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.message)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.file)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.function)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.line)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.metadata)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.tag)
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: ", "))
        
        XCTAssertEqual(formatItems.removeFirst(), FormatItem.default(value: "default"))
    }
    
    func test_formatItemDescription() {
        var formatItems = FormatItem.allCases
        
        XCTAssertEqual(formatItems.removeFirst().description, "date")
        XCTAssertEqual(formatItems.removeFirst().description, "logLevel")
        XCTAssertEqual(formatItems.removeFirst().description, "message")
        XCTAssertEqual(formatItems.removeFirst().description, "file")
        XCTAssertEqual(formatItems.removeFirst().description, "function")
        XCTAssertEqual(formatItems.removeFirst().description, "line")
        XCTAssertEqual(formatItems.removeFirst().description, "metadata")
        XCTAssertEqual(formatItems.removeFirst().description, "tag")
        
        let defaultFormatItem = FormatItem.default(value: "defaultItem")
        XCTAssertEqual(defaultFormatItem.description, "defaultItem")
    }
    
    func test_formatter() {
        let formatter = BaseFormatter()
        let destination = TestDestination(logLevel: .verbose, formatter)
        
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        
        let metadata: Logger.Metadata = ["Key": ["Item", "Item2"]]
        let message = "Test"
        let tag: Logger.MetadataValue = "Tag"
        
        formatter.logFormat = "[logLevel] message - file / function / line: metadata, tag"
        let lineNumber = #line + 1
        logger.debug(message: "Test", metadata: metadata, tag: tag)
        let formattedMessage = destination.formatter.format(destination.output.removeFirst())
        
        XCTAssertEqual(formattedMessage, "[DEBUG] \(message) - \(#file) / \(#function) / \(lineNumber): \(metadata), \(tag)")
    }
    
    func test_formatterWithNilValues() {
        let formatter = BaseFormatter(substituteEmpty: true)
        let destination = TestDestination(logLevel: .verbose, formatter)
        
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        
        let message = "Test"
        
        formatter.logFormat = "[logLevel] message - function: metadata, tag"
        logger.debug(message: "Test", metadata: nil, tag: nil)
        let formattedMessage = destination.formatter.format(destination.output.removeFirst())
        
        XCTAssertEqual(formattedMessage, "[DEBUG] \(message) - \(#function): <Empty>, <Empty>")
    }
    
    func test_formatterWithNewFormat() {
        let formatter = BaseFormatter()
        let destination = TestDestination(logLevel: .verbose, formatter)
        
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        
        let metadata: Logger.Metadata = ["Key": ["Item", "Item2"]]
        let message = "Test"
        let tag: Logger.MetadataValue = "Tag"
        
        // Send initial log
        formatter.logFormat = "[logLevel] message - function: metadata, tag"
        logger.debug(message: "Test", metadata: metadata, tag: tag)
        let formattedMessage = destination.formatter.format(destination.output.removeFirst())
        
        XCTAssertEqual(formattedMessage, "[DEBUG] \(message) - \(#function): \(metadata), \(tag)")
        
        // Change LogFormat and send another log
        formatter.logFormat = "tag, metadata, function: message - [logLevel]"
        logger.debug(message: "Test", metadata: metadata, tag: tag)
        let newFormattedMessage = destination.formatter.format(destination.output.removeFirst())
        
        XCTAssertEqual(newFormattedMessage, "\(tag), \(metadata), \(#function): \(message) - [DEBUG]")
    }
    
    func test_formatterDateFormat() {
        let formatter = BaseFormatter()
        let destination = TestDestination(logLevel: .verbose, formatter)
        
        let logger = Mock.baseLogger(logLevel: .debug, destination: destination)
        let message = "Test"
        
        let dateFormat = "yyyy-MM-dd HH"
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        formatter.dateFormat = dateFormat
        
        formatter.logFormat = "date: message"
        logger.debug(message: "Test")
        let formattedMessage = destination.formatter.format(destination.output.removeFirst())
        
        XCTAssertEqual(formattedMessage, "\(dateFormatter.string(from: Date())): \(message.description)")
    }
}
