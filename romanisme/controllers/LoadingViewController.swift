//
//  ViewController.swift
//  romanisme
//
//  Created by Alex Aron on 13/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit
import Firebase

class LoadingViewController: UIViewController {

    private let activityIndicator = ActivitySpinner()

    var isAnimating: Bool = false

    let centerView: UIView = {
        let center = UIView()
        center.translatesAutoresizingMaskIntoConstraints = false
        center.backgroundColor = .white
        let screenWidth: CGFloat = UIScreen.main.bounds.width * 0.4
        center.widthAnchor.constraint(equalToConstant: screenWidth) .isActive = true
        center.heightAnchor.constraint(equalToConstant: screenWidth * 2.5).isActive = true
        return center
    }()

    let logoView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "AppLogo-Dark-Full")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    func setupView() {
        
        view.addSubview(centerView)
        centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerView.addSubview(logoView)
        logoView.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        logoView.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        logoView.contentMode = .scaleAspectFit
        centerView.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        makeServiceCall()
    }

    private func makeServiceCall() {
        console(print: "Method Started", self)
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(2000)) {
            self.activityIndicator.stopAnimating()
            if AuthService.user.isAuthenticated {
                console(print: "User is Authenticated", self)
                if let user = AuthService.user.info {
                    if user.isRegistered {
                        console(print: "User is Registered", self)
                        AppDelegate.shared.rootViewController.loadMainController()
                    } else {
                        console(print: "User not Registered", self)
                        AppDelegate.shared.rootViewController.loadAuthController()
                    }
                }
            } else{
                console(print: "User not Authenticated", self)
                AppDelegate.shared.rootViewController.loadAuthController()
            }
        }
    }

}

