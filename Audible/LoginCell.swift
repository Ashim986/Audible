//
//  LoginCell.swift
//  Audible
//
//  Created by ashim Dahal on 10/16/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import UIKit



class LoginCell : UICollectionViewCell{
    
    let logoView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailTextFiled : LeftPaddedTextField = {
        let textFiled = LeftPaddedTextField()
        textFiled.placeholder = "Enter Email"
        textFiled.layer.borderColor = UIColor.lightGray.cgColor
        textFiled.layer.borderWidth = 1
        textFiled.keyboardType = .emailAddress
        return textFiled
    }()
    let passWordTextField : LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 1
        return textField
    }()
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    // this is model class having access to Controller variable Which is not desired properties for model class ... Instead we will implement protocol to establish the connection
    
//    var loginController : LoginController?
    
    weak var delegate : LoginControllerDelegate?
    
    @objc func handleLogin() {
       // loginController?.finishLoggingIn()
       delegate?.finishLoggingIn()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoView)
        addSubview(emailTextFiled)
        addSubview(passWordTextField)
        addSubview(loginButton)
        anchorForLayout()
    }
    func anchorForLayout(){
        
        logoView.topAnchor.constraint(equalTo: centerYAnchor, constant: -230).isActive = true
        logoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        _ = emailTextFiled.anchor(logoView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        _ = passWordTextField.anchor(emailTextFiled.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        _ = loginButton.anchor(passWordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LeftPaddedTextField : UITextField{
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}








