//
//  BorrarTweetsModel.swift
//  PlatziTweets
//
//  Created by Maria Fernanda Paz Rodriguez on 6/06/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

class BorrarTweetsModel {
    
struct BorrarTweets : Codable {
    let isDone : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case isDone = "isDone"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isDone = try values.decodeIfPresent(Bool.self, forKey: .isDone)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        }

    }
}
