//
//  FormattableTests.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/12.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import XCTest
@testable import Swidoodle

class FormattableTests: XCTestCase {
    func test_metadataValue() {
        let string: Logger.MetadataValue = "Value"
        XCTAssertEqual(string.description, "Value")
        
        let stringWithInterpolation: Logger.MetadataValue = "Value\(1)"
        XCTAssertEqual(stringWithInterpolation.description, "Value1")
        
        let array: Logger.MetadataValue = ["Value", "Value2"]
        XCTAssertEqual(array.description, "Value, Value2")
        
        let dict: Logger.MetadataValue = ["Key": ["Value1", "Value2"]]
        XCTAssertEqual(dict.description, "Key: Value1, Value2")
    }
    
    func test_metadata() {
        var metadata: Logger.Metadata = ["Key": "String",
                                         "Key2": ["Array1", "Array2"],
                                         "Key3": "String\(1)"]
        metadata["Key"] = "Overwrite"
    
        XCTAssertEqual(metadata["Key"]?.description, "Overwrite")
        XCTAssertEqual(metadata["Key2"]?.description, "Array1, Array2")
        XCTAssertEqual(metadata["Key3"]?.description, "String1")
    }
    
    func test_tag() {
        let tag: Logger.Tag = "Tag"
        XCTAssertEqual(tag.description, "Tag")
        
        let nilTag: Logger.Tag? = nil
        XCTAssertEqual(nilTag.debugDescription, "")
    }
}
