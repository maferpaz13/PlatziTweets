//
//  Header.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation
import Alamofire

struct Header {
    var dict = [
        
        "Authorization" : ""
        
        ] as HTTPHeaders
    
    init(Authorization: String){
        
        dict["Authorization"] = Authorization
        
    }
}
