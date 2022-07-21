//
//  RegisterPostStruct.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation


struct PostRegister {
    
    var dict = [
        
        "email" : "",
        "password": "",
        "names" : ""
        
        ] as [String: Any]
    
    init(email: String, password: String, names: String){
        
        dict["email"] = email
        dict["password"] = password
        dict["names"] = names
        
    }
    
}
