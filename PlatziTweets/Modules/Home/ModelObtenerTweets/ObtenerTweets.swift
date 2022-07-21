//
//  ObtenerTweets.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import Foundation

class ObtenerTweetsModel {
    
    struct DataTweet : Codable {
        
        let id : String?
        let author : Author?
        let createdAt : String?
        let hasImage : Bool?
        let hasLocation : Bool?
        let hasVideo : Bool?
        let imageUrl : String?
        let location : Location?
        let text : String?
        let videoUrl : String?
        let errores : String?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case author = "author"
            case createdAt = "createdAt"
            case hasImage = "hasImage"
            case hasLocation = "hasLocation"
            case hasVideo = "hasVideo"
            case imageUrl = "imageUrl"
            case location = "location"
            case text = "text"
            case videoUrl = "videoUrl"
            case errores = "error"
        }

        init(from decoder: Decoder) throws {
            
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            do {
                id = try values.decodeIfPresent(String.self, forKey: .id)
            }catch{
                id = ""
            }
            
            do {
                author = try values.decodeIfPresent(Author.self, forKey: .author)
            }catch{
                author = nil
            }
            
            do {
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
            }catch{
                createdAt = ""
            }
            
            do {
                hasImage = try values.decodeIfPresent(Bool.self, forKey: .hasImage)
            }catch{
                hasImage = false
            }
            
            do{
                hasLocation = try values.decodeIfPresent(Bool.self, forKey: .hasLocation)
            }catch{
                hasLocation = false
            }
            
            do{
                hasVideo = try values.decodeIfPresent(Bool.self, forKey: .hasVideo)
            }catch{
                hasVideo = false
            }
            
            do{
                imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
            }catch{
                imageUrl = ""
            }
                        
            do {
                
            location = try values.decodeIfPresent(Location.self, forKey: .location)
                
            }catch{
                
            location = nil
                
            }
            
            do {
                text = try values.decodeIfPresent(String.self, forKey: .text)
            }catch{
                text = ""
            }
            
            do {
               videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl)
            }catch{
                videoUrl = ""
            }
            
            do{
                
                errores = try values.decodeIfPresent(String.self, forKey: .errores)
                
            }catch{
                
                errores = ""
                
            }
            
            
        }

    }
    
    struct Author : Codable {
        let createdAt : String?
        let email : String?
        let id : String?
        let names : String?
        let nickname : String?

        enum CodingKeys: String, CodingKey {

            case createdAt = "createdAt"
            case email = "email"
            case id = "id"
            case names = "names"
            case nickname = "nickname"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            do {
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
            }catch{
                createdAt = ""
            }
            
            do {
                email = try values.decodeIfPresent(String.self, forKey: .email)
            }catch{
                email = ""
            }
            
            do {
                id = try values.decodeIfPresent(String.self, forKey: .id)
            }catch{
                id = ""
            }
            
            do {
                names = try values.decodeIfPresent(String.self, forKey: .names)
            }catch{
                names = ""
            }
            
            do {
                nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
            }catch{
                nickname = ""
            }
                        
        }

    }
    
    struct Location : Codable {
        let latitude : Double?
        let longitude : Double?

        enum CodingKeys: String, CodingKey {

            case latitude = "latitude"
            case longitude = "longitude"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
            longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        }

    }
    
}

