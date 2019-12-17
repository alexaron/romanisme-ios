//
//  MainTabBarController.swift
//  romanisme
//
//  Created by Alex Aron on 13/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//

import UIKit
import LBTAComponents
import RevealingSplashView
import Firebase

class MainTabBarController: UITabBarController {
    
    
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }

       let revealingSplashView: RevealingSplashView = {
           let view = RevealingSplashView(iconImage: UIImage(named: "AppLogo-Short")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor(red: 255 / 255, green: 190 / 255, blue: 5 / 255, alpha: 1))
           view.minimumBeats = 10
           view.duration = 2
           view.playHeartBeatAnimation()
           return view
       }()


    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //revealingSplashView.finishHeartBeatAnimation()
        //view.addSubview(revealingSplashView)
        
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .black
        viewControllers = [
            createNavConroller(viewController: Ads(), title: "Ads", iconImage: "ads"),
            createNavConroller(viewController: Services(), title: "Services", iconImage: "services"),
            createNavConroller(viewController: Community(), title: "Community", iconImage: "community"),
            createNavConroller(viewController: News(), title: "News", iconImage: "news"),
            createNavConroller(viewController: Account(), title: "Account", iconImage: "account")
        ]
    }

    fileprivate func createNavConroller(viewController: UIViewController, title: String, iconImage: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        //navController.navigationBar.titleTextAttributes = navTitleAttrs as [NSAttributedString.Key : Any]
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: iconImage)
        //navController.tabBarItem.selectedImage = UIImage(named: iconImage)
        return navController
    }
    
    


}
