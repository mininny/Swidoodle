//
//  XCTest+Swidoodle.swift
//  SwiddodleTests
//
//  Created by Minhyuk Kim on 2020/07/13.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation
import XCTest

extension XCTest {
    func identifier(function: String = #function) -> String {
        return "com.mininny.swidoodle.test.\(function)"
    }
}
