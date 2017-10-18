//
//  HomeController.swift
//  Audible
//
//  Created by ashim Dahal on 10/17/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let homePageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "home")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "We're Logged in"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(handelSignOut))
        view.addSubview(homePageView)
        homePageViewAnchor()
    }
    
    func homePageViewAnchor() {
        NSLayoutConstraint.activate([homePageView.topAnchor.constraint(equalTo:view.topAnchor, constant : 64), homePageView.leftAnchor.constraint(equalTo: view.leftAnchor),homePageView.rightAnchor.constraint(equalTo: view.rightAnchor), homePageView.bottomAnchor.constraint(equalTo: view.bottomAnchor) ])
    }
    
    @objc func handelSignOut() {
       
        UserDefaults.standard.setIsLoggedIn(value: false)
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}
