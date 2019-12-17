//
//  RootViewController.swift
//  romanisme
//
//  Created by Alex Aron on 13/12/2019.
//  Copyright © 2019 Devlex Solutions Ltd. All rights reserved.
//
import UIKit

class RootViewController: UIViewController {


    private var current: UIViewController

    init() {
        self.current = LoadingViewController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func loadMainController() {
           let mainController = MainTabBarController()
           animateDismissTransition(to: mainController)
       }
       
       func loadAuthController() {
//          let authController = AuthVerification()
//          let authScreen = UINavigationController(rootViewController: authController)
//          animateFadeTransition(to: authScreen)
        
        let authController = AuthNavigationController()
        //let authScreen = UINavigationController(rootViewController: authController)
        animateFadeTransition(to: authController)
        
        
       }
       
       private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
           current.willMove(toParent: nil)
           addChild(new)
           transition(from: current, to: new, duration: 0.0, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
          }) { completed in
           self.current.removeFromParent()
           new.didMove(toParent: self)
               self.current = new
               completion?()  //1
          }
       }
       
       private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
           _ = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
           current.willMove(toParent: nil)
           addChild(new)
           transition(from: current, to: new, duration: 0, options: [], animations: {
             new.view.frame = self.view.bounds
          }) { completed in
           self.current.removeFromParent()
           new.didMove(toParent: self)
             self.current = new
             completion?()
          }
       }
}
