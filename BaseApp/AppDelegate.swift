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

    private var loader: UIAlertController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Permissions
        PushNotificationsManager.shared.configure()
        LocationManager.shared.configure()

        // Root view controller
        var vc: UIViewController = R.storyboard.login.instantiateInitialViewController()!

        if APIClient.shared.isAuthenticated {
            vc = R.storyboard.main.instantiateInitialViewController()!
        }

        window?.rootViewController = vc

        window?.makeKeyAndVisible()

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        PushNotificationsManager.shared.register(token: deviceToken)
    }

}

// MARK: Auth Functions

extension AppDelegate {

    func logout(toUpdate: Bool = false) {
        UserDefaults.standard.remove(.appSid)
        // TODO: Handle logout; Redirect to Login

        // TODO: If logout endpoint is available
//        APIClient.shared.request(to: .login,
//                                 method: .post(AppSidRequest.init()),
//                                 responseType: BaseAPIResponse.self) { result in
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

        ViewPresenter.presentAlert(.custom(title: title, message: message),
                                   buttonTitle: "Update")
    }

}

// MARK: Presenter Functions

extension AppDelegate {

    /// Toggles loader display to signify ongoing process.
    func toggleLoader() {
        // Dismiss loader
        if let loader = loader {
            loader.dismiss(animated: true) { [weak self] in
                self?.loader = nil
            }

            return
        }

        // Present loader
        let alert = UIAlertController(title: nil,
                                      message: "Please wait...",
                                      preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = .gray

        loader = alert
        
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        ViewPresenter.present(alert: alert)
    }

}

// MARK: Handle Foreground/Background

extension AppDelegate {

    func applicationWillEnterForeground(_ application: UIApplication) {
        LocationManager.shared.startMonitorLocation()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        LocationManager.shared.stopMonitoringLocation()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        LocationManager.shared.stopMonitoringLocation()
    }

}
