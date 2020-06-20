//
//  Formattable.swift
//  Swidoodle
//
//  Created by Minhyuk Kim on 2020/06/20.
//  Copyright © 2020 Mininny. All rights reserved.
//

import Foundation

protocol Formattable: CustomStringConvertible { }
extension String: Formattable { }
extension Logger.Metadata: Formattable { }
extension UInt: Formattable { }
extension Date: Formattable { }
