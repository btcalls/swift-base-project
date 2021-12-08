//
//  GlobalFunctions.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

// MARK: Debugging

struct Debugger {

    /// Print function only for debugging a single item on debug environments.
    /// - Parameters:
    ///   - items: The items to print.
    ///   - filename: The filename of file where print originated.
    ///   - function: The function where the print is called.
    ///   - line: The line number within file.
    ///   - separator: The separator to use.
    ///   - terminator: The items terminator to use.
    static func print(_ items: Any...,
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

}

// MARK: Utils

struct ValueBox<T> {

    typealias Listener = (T?) -> Void

    private var listener: Listener?
    private var value: T? {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T? = nil) {
        self.value = value
    }

    mutating func set(value: T?) {
        self.value = value
    }

    mutating func bind(listener: Listener?) {
        self.listener = listener

        listener?(value)
    }

}

struct ViewPresenter {

    private static var topMostController: UIViewController? {
        if let window = UIWindow.key, var controller = window.rootViewController {
            while let presentedViewController = controller.presentedViewController {
                controller = presentedViewController
            }

            return controller
        }

        return nil
    }

    /// Presents a message to app via toast.
    /// - Parameter message: The message to display.
    static func present(_ message: String) {
        // TODO: Toast
    }

    /// Presents an alert controller.
    /// - Parameter alert: The alert to display.
    static func present(alert: UIAlertController) {
        guard let topMostController = topMostController else {
            preconditionFailure("No controller available to present loader.")
        }

        topMostController.present(alert, animated: true, completion: nil)
    }

    /// Presents a basic alert with a single action at the topmost controller.
    /// - Parameters:
    ///   - type: Type of dialog to display.
    ///   - buttonTitle: Title to display on the action.
    static func presentAlert(_ type: DialogType, buttonTitle: String = "OK") {
        guard let topMostController = topMostController else {
            preconditionFailure("No controller available to present loader.")
        }

        var title = ""
        var message = ""

        switch type {
        case .custom(let t, let m):
            title = t
            message = m

        case .error(let error):
            title = "Oops!"
            message = error.localizedDescription
        }

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(.init(title: buttonTitle, style: .cancel))
        topMostController.present(alert, animated: true, completion: nil)
    }

}
