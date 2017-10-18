//
//  MainNavigationController.swift
//  Audible
//
//  Created by ashim Dahal on 10/17/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            
            // assume user is logged in
            let homeController = HomeController()
            // viewController is the property that exists on UI navigation Controller, it an array of all the controller that exists on navigation stack. viewController with only one component here with homeController means the very first controller it will see will be homeController
            viewControllers = [homeController]
            
        }else{
            // cannot directly present the view controller
            perform(#selector(showLoginController), with: nil, afterDelay: 0.2)
       
        }
    }
    fileprivate func isLoggedIn() -> Bool {
        
        return UserDefaults.standard.isLoggedIn()
        
    }
   @objc func showLoginController(){
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}


