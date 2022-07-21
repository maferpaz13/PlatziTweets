//
//  LoginModel.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

struct PostLoginStrutc {
    
    var dict = [
        
        "email" : "",
        "password": ""
        
        ] as [String: Any]
    
    init(email: String, password: String){
        
        dict["email"] = email
        dict["password"] = password
        
    }
    
}
