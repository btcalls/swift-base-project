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

// MARK: Auth Functions

extension AppDelegate {

    func logout(toUpdate: Bool = false) {
        UserDefaults.standard.remove(.appSid)
        // TODO: Handle logout; Redirect to Login

        // TODO: If logout endpoint is available
//        SLAPIClient.shared.post(type: BaseAPIResponse.self,
//                                endpoint: .logout,
//                                body: AppSidRequest.init()) { result in
//            switch result {
//            case .success(_):
//                // TODO: Handle logout; Redirect to Login
//                break
//
//            case .failure(_):
//                break
//            }
//        }
    }

    func updateApp() {
        let title = "Update App"
        let message = """
        \(Bundle.main.displayAppVersion)

        A newer version of \(Bundle.main.appName) is now available.

        \(Bundle.main.appName) will be updated automatically.
        """

        presentDialog(type: .custom(title: title, message: message),
                      buttonTitle: "Update")
    }

}

// MARK: Presenter Functions

extension AppDelegate {

    /// Presents a message to app via toast.
    /// - Parameter message: The message to display.
    func present(_ message: String) {
        // TODO: Toast
    }

    /// Presents a basic alert with a single action at the topmost controller.
    /// - Parameters:
    ///   - type: Type of dialog to display.
    ///   - buttonTitle: Title to display on the action.
    ///   - cancelTitle: Title to display on the cancel action.
    func presentDialog(type: SLDialogType, buttonTitle: String = "OK") {
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
        topMostController?.present(alert, animated: true, completion: nil)
    }

}
