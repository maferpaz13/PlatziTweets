//
//  ObtenerTweetsViewModel.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

class ObtenerTweetsViewModel{
    
    func getTweet(completation: @escaping ([ObtenerTweetsModel.DataTweet]) -> ()){
        
        ObtenerTweetsAPIClient().GetTweets() { (Result) in
            
            switch Result.result{
                
            case .success(_):
                
                if let data = try? JSONDecoder().decode([ObtenerTweetsModel.DataTweet].self, from: Result.data!) as [ObtenerTweetsModel.DataTweet] {
                    
                    completation(data)
                    
                }else{
                    print("no pude hacer el JSON")
                    completation([])
                }
                
            case .failure(_):
                
                completation([])
                
            }
            
        }
        
    }
    
    func postTweet(parameters: PostTweetStrutc,completation: @escaping (ObtenerTweetsModel.DataTweet?) -> ()){
        
        ObtenerTweetsAPIClient().PostTweets(parameters: parameters ,completion: { (Result) in
            
            switch Result.result{
                
            case .success(_):
                
                if let data = try? JSONDecoder().decode(ObtenerTweetsModel.DataTweet.self, from: Result.data!) as ObtenerTweetsModel.DataTweet? {
                    
                    completation(data)
                    
                }else{
                    print("no pude hacer el JSON")
                    completation(nil)
                }
                
            case .failure(_):
                
                completation(nil)
                
            }
            
        })
        
    }
    
    func deleteTweets(postId: String,completation: @escaping (BorrarTweetsModel.BorrarTweets?) -> ()){
        
        ObtenerTweetsAPIClient().DeleteTweets(postId: postId) { (Result) in
            switch Result.result {
            case .success(_):
                
                if let data = try? JSONDecoder().decode(BorrarTweetsModel.BorrarTweets.self, from: Result.data!) as BorrarTweetsModel.BorrarTweets? {
                    
                    completation(data)
                    
                }else{
                    print("no pude hacer el JSON")
                    completation(nil)
                }
                
            case .failure(_):
                
                completation(nil)
            }
        }
    }
}
