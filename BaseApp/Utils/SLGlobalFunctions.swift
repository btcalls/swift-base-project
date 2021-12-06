//
//  SLGlobalFunctions.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation

// MARK: Debugging

/// Print function only for debugging a single item on debug environments.
/// - Parameters:
///   - items: The items to print.
///   - filename: The filename of file where print originated.
///   - function: The function where the print is called.
///   - line: The line number within file.
///   - separator: The separator to use.
///   - terminator: The items terminator to use.
public func printDebug(_ items: Any...,
                       filename: String = #file,
                       function: String = #function,
                       line: Int = #line,
                       separator: String = " ",
                       terminator: String = "\n") {
    var key: String?

    #if DEBUG
    key = "Dev"
    #elseif QA
    key = "QA"
    #endif

    guard let key = key else {
        return
    }

    let file = URL(fileURLWithPath: filename).lastPathComponent
    let output = items.map { "\n\t-> \($0)" }.joined(separator: separator)
    let pretty = "\(key) - \(file) \(function) at line #\(line)\(output)"

    Swift.print(pretty, terminator: terminator)
}
