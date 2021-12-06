//
//  ViewController.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

struct ThreadsResponse: APIResponseDecodable {

    var acknowledge: Acknowledge
    var fullMessage: String
    var message: String
    var threads: [ChatThread]

}

struct ChatThread: Codable {

    var chatMessage: String
    var chatThreadId: Int
    var chatTime: String
    var employeeList: String
    var isRead: Bool

}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if SLAPIClient.shared.isAuthenticated {
            AppDelegate.shared.logout()
        } else {
            login()
        }
    }

    private func login() {
        SLAPIClient.shared.post(type: LoginResponse.self,
                                endpoint: .login,
                                body: LoginRequest.testParams) { [weak self] result in
            switch result {
            case .success(let response):
                self?.setAppSid(response.appSid)

            case .failure(let error):
                printDebug("Error: \(error.localizedDescription)")
            }
        }
    }

    private func setAppSid(_ appSid: String) {
        UserDefaults.standard.set(appSid, forKey: .appSid)
    }
    
}
