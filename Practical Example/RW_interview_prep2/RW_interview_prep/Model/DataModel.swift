//
//  DataModel.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/25/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

struct Arcdata : Decodable {
    var data : [ArticleAndVideoData]
}

struct ArticleAndVideoData: Identifiable, Decodable, Comparable {
    
    static func < (lhs: ArticleAndVideoData, rhs: ArticleAndVideoData) -> Bool {
        lhs.attributes.released_at < rhs.attributes.released_at
    }
    
    static func == (lhs: ArticleAndVideoData, rhs: ArticleAndVideoData) -> Bool {
        lhs.attributes.released_at == rhs.attributes.released_at
    }
    
    let id : String
    let type : String
    let attributes: ArticleAndVideoAttributee
    let relationships: [String : Relationship]
    let links: [String: String?]
    
    struct ArticleAndVideoAttributee: Codable {
        
        let uri: String
        let name: String?
        let description: String
        let released_at: String
        let free: Bool
        let difficulty: String?
        let content_type: String
        let duration: Int16?
        let popularity: Double?
        let technology_triple_string: String
        let contributor_string: String
        let ordinal: String?
        let professional: Bool
        let description_plain_text: String
        let video_identifier: String?
        let parent_name: String?
        let card_artwork_url: String
    }
    
    struct Relationship: Codable {
        let domains: [String: [Domain]]?
        let childContents: Meta?
        let progression: ProgressionData?
        let bookmark: BookmarkData?

        enum CodingKeys: String, CodingKey {
            case domains = "domains"
            case childContents = "child_contents"
            case progression = "progression"
            case bookmark = "bookmark"
    }
        struct Domain: Codable {
            let id: String
            let type: String
        }

        struct Meta: Codable {
            let count: Int
        }

        struct ProgressionData: Codable {
            let data: Bool?
        }

        struct BookmarkData: Codable {
            let data: Bool?
        }
    }
}

struct VidData : Decodable {
    var data : [VideoData]
}

struct VideoData : Identifiable, Decodable, Comparable {

    static func < (lhs: VideoData, rhs: VideoData) -> Bool {
        lhs.attributes.released_at < rhs.attributes.released_at
    }

    static func == (lhs: VideoData, rhs: VideoData) -> Bool {
        lhs.attributes.released_at < rhs.attributes.released_at
    }

    let id : String
    let type : String
    let attributes : VideoAttribute
//    let relationships
    let links : [String : String?]

    struct VideoAttribute: Codable {
        let uri : String
        let name : String?
        let description : String
        let released_at : String
        let free : Bool
        let difficulty: String?
        let content_type : String
        let duration : Int
        let popularity: Double?
        let technology_triple_string: String
        let contributor_string: String
        let ordinal: String?
        let professional: Bool
        let description_plain_text: String
        let video_identifier: String?
        let parent_name: String?
        let card_artwork_url: String
    }
}
