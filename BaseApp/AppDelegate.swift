//
//  AppDelegate.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = UIApplication.shared.delegate as! AppDelegate

    var window: UIWindow?

    private var loader: UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: "Please wait...",
                                      preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .gray

        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)

        return alert
    }
    private var topMostController: UIViewController? {
        if let window = UIWindow.key, var controller = window.rootViewController {
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

        var vc: UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!

        if APIClient.shared.isAuthenticated {
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        }

        window?.rootViewController = vc

        window?.makeKeyAndVisible()

        return true
    }

}

// MARK: Auth Functions

extension AppDelegate {

    func logout(toUpdate: Bool = false) {
        UserDefaults.standard.remove(.appSid)
        // TODO: Handle logout; Redirect to Login

        // TODO: If logout endpoint is available
        APIClient.shared.post(type: BaseAPIResponse.self,
                              endpoint: .logout,
                              body: AppSidRequest.init()) { result in
            switch result {
            case .success(_):
                // TODO: Handle logout; Redirect to Login
                break

            case .failure(_):
                break
            }
        }
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
    func presentDialog(type: DialogType, buttonTitle: String = "OK") {
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

    /// Toggles loader display to signify ongoing process.
    func toggleLoader() {
        guard let topMostController = topMostController else {
            preconditionFailure("No controller available to present loader.")
        }

        // Dismiss loader
        if topMostController.presentedViewController == loader {
            loader.dismiss(animated: true, completion: nil)
        } else {
            topMostController.present(loader, animated: true, completion: nil)
        }
    }

}
