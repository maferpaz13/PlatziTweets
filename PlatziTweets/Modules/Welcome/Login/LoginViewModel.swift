//
//  LoginViewModel.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject{
    
    func postLogin(parameters:PostLoginStrutc,completation: @escaping (_ barnie: RegisterLoginModel.RegisterLogin?, _ ysusamigos: Data?) -> ()){
        
        LoginAPIClient().PostLogin(parameters:parameters ) { (Result) in
            
            switch Result.result{
                
            case .success(_):
                
                if let data = try? JSONDecoder().decode(RegisterLoginModel.RegisterLogin.self, from: Result.data!) as RegisterLoginModel.RegisterLogin {
                    
                    if data.error != nil {
                        
                        completation(nil, nil)
                        
                    }else{
                        
                        completation(data, Result.data!)
                        
                    }
                }
                
            case .failure(_):
                
                completation(nil, nil)
                
            }
            
        }
        
    }
    
}
