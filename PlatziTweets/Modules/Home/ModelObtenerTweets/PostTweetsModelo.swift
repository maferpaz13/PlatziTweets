//
//  PostTweetsModelo.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

struct PostTweetStrutc {
    
    var dict = [
        
        "text" : "",
        "imageUrl": "",
        "videoUrl": "",
        "location": [
            "latitude" : 0.0,
            "longitude" : 0.0
        ]
        
        ] as [String: Any]
    
    
    init(text: String, imageUrl: String?,videoUrl: String?, latitude: Double?, longitude : Double?){
        
        dict["text"] = text
        dict["imageUrl"] = imageUrl
        dict["videoUrl"] = videoUrl
        
        if latitude != nil {
            
            var location = dict["location"] as! [String: Any]
            
            location["latitude"] = latitude
            location["longitude"] = longitude
            dict["location"] = location
            
        }else{
            
            let index = dict.index(forKey: "location")
            dict.remove(at: index!)
            
        }
        
        
        
        
    }
    
}
