//
//  EndPoints.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/26/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

struct EndPoints {
    static let domain = "https://platzi-tweets-backend.herokuapp.com/api/v1"
}


struct URLPost {
    static let auth = "/auth"
    static let signin = "/register"
    static let posttweets = "/posts"
}

struct URLGet {
    static let gettweets = "/posts"
}

struct URLDelete {
    static var deleteTweets = "/posts/{ID_DEL_POST}"
}
