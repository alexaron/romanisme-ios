//
//  AuthSuccessController.swift
//  romanisme
//
//  Created by Alex Aron on 16/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit

class AuthWelcome: AuthControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        
        if let user = AuthService.user.info {
            print(user)
        }
        self.setTarget = .main

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

