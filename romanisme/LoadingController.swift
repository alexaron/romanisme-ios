//
//  ViewController.swift
//  romanisme
//
//  Created by Alex Aron on 13/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let logo: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "AppLogo-Short")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.sizeToFit()
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255/255, green: 190/255, blue: 5/255, alpha: 1)
        view.addSubview(logo)
        
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Do any additional setup after loading the view.
    }


}

