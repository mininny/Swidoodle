//
//  Formatter.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/08.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

protocol Formatter {
    func format(_ content: Formattable) -> String
}

protocol Formattable { }
