//
//  RegisterAPIClient.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation
import Alamofire

class RegisterAPIClient{
    
    func PostRegis(parameters:PostRegister,completion : @escaping (AFDataResponse<Any>) -> ()) {
        
        AF.request(EndPoints.domain+URLPost.signin, method: .post, parameters: parameters.dict, encoding: JSONEncoding.default).responseJSON {
            
            (Result) in
            
            completion(Result)
            
        }
        
    }
    
}

