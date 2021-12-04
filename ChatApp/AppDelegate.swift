//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = UIApplication.shared.delegate as! AppDelegate

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
    ///   - type: Type of dialog to display.
    func presentDialog(type: DialogType) {
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

        alert.addAction(.init(title: "OK", style: .cancel))
        topMostController?.present(alert, animated: true, completion: nil)
    }

}
