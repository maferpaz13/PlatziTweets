//
//  RegisterViewModel.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation


class RegisterViewModel{
    
    func postRegister(parameters:PostRegister,completation: @escaping (RegisterLoginModel.RegisterLogin?) -> ()){
        
        RegisterAPIClient().PostRegis(parameters:parameters ) { (Result) in
            
            switch Result.result{
                
            case .success(_):
                
                if let data = try? JSONDecoder().decode(RegisterLoginModel.RegisterLogin.self, from: Result.data!) as RegisterLoginModel.RegisterLogin {
                    
                    completation(data)
                    
                }
                
            case .failure(_):
                
                completation(nil)
                
            }
            
        }
        
    }
    
}
