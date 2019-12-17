//
//  AdsController.swift
//  romanisme
//
//  Created by Alex Aron on 13/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit
import Firebase

class Ads: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Out", style: .plain, target: self, action: #selector(handleLogout))
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @objc func handleLogout() {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to signt out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
            if action.style == .default {
                AuthService.signOut() { error in
                    if let error = error {
                        print(error)
                        return
                    } else {
                        AppDelegate.shared.rootViewController.loadAuthController()
//                        self.window = UIWindow(frame: UIScreen.main.bounds)
//                        self.window?.rootViewController = RootViewController()
//                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
