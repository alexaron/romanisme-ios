//
//  Verification.swift
//  romanisme
//
//  Created by Alex Aron on 16/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit

class AuthVerification: AuthControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verification"
        currentIndex = 0
        auth?.authVerify(phone: "+447818998446") { error in
            if let error = error {
                print(error)
            }else {
                self.setTarget = .push
                //print(self.auth?.verificationId ?? "No verificationId")
            }
        }
    }
}
