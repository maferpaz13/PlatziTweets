//
//  ObtenerTweetsAPIClient.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation
import Alamofire

class ObtenerTweetsAPIClient {
    
  func GetTweets(completion : @escaping (AFDataResponse<Any>) -> ()) {
        
    AF.request(EndPoints.domain+URLGet.gettweets, method: .get, parameters: nil, encoding: JSONEncoding.default,headers: Header.init(Authorization: LoginViewController.loginInfo!.token!).dict).responseJSON {
        
            (Result) in
            completion(Result)
            
        }
    
    }
    
    func PostTweets(parameters: PostTweetStrutc,completion : @escaping (AFDataResponse<Any>) -> ()) {
        
        AF.request(EndPoints.domain+URLPost.posttweets, method: .post, parameters: parameters.dict, encoding: JSONEncoding.default,headers: Header.init(Authorization: LoginViewController.loginInfo!.token!).dict).responseJSON {
        
            (Result) in
            completion(Result)
            print(Result.debugDescription)
        }
    
    }
    
    func DeleteTweets(postId: String, completion : @escaping (AFDataResponse<Any>) -> ()){
        
        let IdReplace = URLDelete.deleteTweets.replacingOccurrences(of: "{ID_DEL_POST}", with: postId)
        
        
        AF.request(EndPoints.domain+IdReplace, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: Header.init(Authorization: LoginViewController.loginInfo!.token!).dict).responseJSON {
            
            (Result) in
            completion(Result)
        }
        
    }
}
