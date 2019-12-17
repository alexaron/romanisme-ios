//
//  Helpers.swift
//  romanisme
//
//  Created by Alex Aron on 16/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import Foundation
import UIKit

public func console( print message: String, function: String = #function, line: Int = #line, column: Int = #column, dsohandle: UnsafeRawPointer = #dsohandle, _ sender: AnyObject) {
    print("Console Print:\n    Sender: \(type(of: sender)) [\(line):\(column)]\n    Method: \(function)\n    Message: \(message)\n")
}
