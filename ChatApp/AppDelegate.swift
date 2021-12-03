//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var topMostController: UIViewController? {
        if var controller = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = controller.presentedViewController {
                controller = presentedViewController
            }

            return controller
        }

        return nil
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Bundle.main.printConfig()

        return true
    }

}

// MARK: Global Functions

extension AppDelegate {

    /// Presents a message to app via toast.
    /// - Parameter message: The message to display.
    func present(_ message: String) {
        // TODO: Toast
    }

    /// Presents an alert dialog at the topmost controller.
    /// - Parameters:
    ///   - title: The title to display.
    ///   - message: The message to display.
    func presentDialog(_ title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(.init(title: "OK", style: .cancel))
        topMostController?.present(alert, animated: true, completion: nil)
    }

}
