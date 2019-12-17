//
//  AuthController.swift
//  romanisme
//
//  Created by Alex Aron on 15/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit

public enum TargetSelector {
    case push
    case main
    case auth
    
    func obj() -> Selector {
        switch self {
        case .push:
            return #selector(AuthControllerBase.handleNavigation)
        case .main:
            return #selector(AuthControllerBase.handleLoadMain)
        case .auth:
            return #selector(AuthControllerBase.handleLoadAuth)
        }
    }
}

class AuthControllerBase: UIViewController {

    var setTarget: TargetSelector = .push {
        didSet{
            navigationButton.isEnabled = true
        }
        willSet(selector){
            navigationButton.addTarget(self, action: selector.obj(), for: .touchUpInside)
            navigationButton.isHidden = false
        }
    }

    var authService: AuthService?

    var auth: AuthService? {
        get {
            return self.authService
        }
    }

    var currentIndex: Int = 0 {
        didSet {
            nextViewController = type(of: self).controllers[self.currentIndex + 1]
        }
    }

    class var controllers: [UIViewController] {
        return [AuthVerification(), AuthConfirmation(), AuthRegistration(), AuthAvatar(), AuthWelcome()]
    }
    var nextViewController = UIViewController()

    let navigationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        button.isEnabled = false
        //button.addTarget(self, action: selector!, for: .touchUpInside)
        //button.addTarget(self, action: #selector(handleNavigation), for: .touchUpInside)
        button.isHidden = true
        return button
    }()


    override func loadView() {
        super.loadView()
        if authService == nil {
            authService = AuthService.shared
        }

//        if testVal == nil {
//            print("Set test val")
//            testVal = 110815
//        }

        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        navigationController?.navigationBar.shadowImage = UIImage()

        view.addSubview(navigationButton)
        navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navigationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
    }

    @objc func handleNavigation() {
        let next = nextViewController as! AuthControllerBase
        next.authService = self.auth
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    @objc func handleLoadMain() {
        AppDelegate.shared.rootViewController.loadMainController()
    }

    @objc func handleLoadAuth() {
        AppDelegate.shared.rootViewController.loadAuthController()
    }
}
