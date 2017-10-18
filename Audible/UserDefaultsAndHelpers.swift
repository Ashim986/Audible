//
//  UserDefaultsAndHelpers.swift
//  Audible
//
//  Created by ashim Dahal on 10/17/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import Foundation

extension  UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value : Bool){
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    func isLoggedIn() -> Bool{
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue )
    }
}
