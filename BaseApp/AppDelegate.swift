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
        // TODO: Enable if needed
//        PushNotificationsManager.shared.configure()
//        LocationManager.shared.configure()

        // TODO: Change when needed
        let needsAuth = false
        
        // Root view controller
        window?.rootViewController = getRootViewController(needsAuth)

        window?.makeKeyAndVisible()

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        PushNotificationsManager.shared.register(token: deviceToken)
    }
    
    private func getRootViewController(_ needsAuth: Bool) -> UIViewController {
        let vc: UIViewController = R.storyboard.home.instantiateInitialViewController()!

        guard needsAuth else {
            return vc
        }
        
        if APIClient.shared.isAuthenticated {
            return vc
        }
        
        return R.storyboard.login.instantiateInitialViewController()!
    }

}

// MARK: Auth Functions

extension AppDelegate {

    func logout(toUpdate: Bool = false) {
        let vc: UIViewController = R.storyboard.login.instantiateInitialViewController()!

        UserDefaults.standard.remove(.accessToken)
        window?.rootViewController = vc

        window?.makeKeyAndVisible()

        // TODO: API call if logout endpoint is available
    }

}

// MARK: Presenter Functions

extension AppDelegate {

    /// Show loader to signify ongoing process.
    /// - Parameter message: The title to display.
    /// - Parameter root: Optional. The root UIViewController where to present the loader.
    /// - Parameter completion: Optional. Handler called when animation is completed.
    func showLoader(message: String = "Please wait...",
                    root: UIViewController? = nil,
                    completion: (() -> Void)? = nil) {
        loader = UIAlertController.loader(message: message, completion: completion)
        
        guard let loader = loader else {
            return
        }
        
        guard let root = root else {
            ViewPresenter.present(alert: loader)
            
            return
        }
        
        root.present(loader, animated: true)
    }

    /// Hide loader to stop process.
    /// - Parameter completion: Optional. Handler called when animation is completed.
    func hideLoader(_ completion: (() -> Void)? = nil) {
        guard let loader = loader else {
            completion?()
            
            return
        }
        
        loader.dismiss(animated: true) { [weak self] in
            self?.loader = nil

            completion?()
        }
        
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
