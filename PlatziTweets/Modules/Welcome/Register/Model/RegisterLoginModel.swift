//
//  RegisterModel.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation



class RegisterLoginModel {
    
    struct RegisterLogin: Codable {
        
        let user : User?
        let token : String?
        let error : String?

        enum CodingKeys: String, CodingKey {

            case user = "user"
            case token = "token"
            case error = "error"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            user = try values.decodeIfPresent(User.self, forKey: .user)
            token = try values.decodeIfPresent(String.self, forKey: .token)
            error = try values.decodeIfPresent(String.self, forKey: .error)
        }

    }
    
    struct User : Codable {
        
        let email : String?
        let nickname : String?
        let names : String?
        let createdAt : String?
        let id : String?

        enum CodingKeys: String, CodingKey {

            case email = "email"
            case nickname = "nickname"
            case names = "names"
            case createdAt = "createdAt"
            case id = "id"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
            names = try values.decodeIfPresent(String.self, forKey: .names)
            createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
            
            do{
                
            id = try values.decodeIfPresent(String.self, forKey: .id)
                
            }catch{
                
            id = ""
                
            }
        }
            

    }
    
}
