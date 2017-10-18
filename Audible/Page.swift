//
//  Page.swift
//  Audible
//
//  Created by ashim Dahal on 10/13/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import UIKit

struct Page {
    let title : String
    let message : String
    let imageName : String
    
    init(title : String, message : String , imageName : String) {
        self.title = title
        self.message = message
        self.imageName = imageName
    }
}
