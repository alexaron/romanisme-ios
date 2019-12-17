//
//  AuthConfirmationViewController.swift
//  romanisme
//
//  Created by Alex Aron on 16/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit

class AuthConfirmation: AuthControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Confirmation"
        currentIndex = 1
        auth?.authConfirm(code: "110815") { userInfo, error in
            guard let user = userInfo else {
                print(error!)
                return
            }
            if user.isRegistered {
                self.currentIndex = 3
            }
            self.setTarget = .push
        }
       
    }
}
