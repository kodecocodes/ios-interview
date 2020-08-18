//
//  RWArticle.swift
//  RWArticles
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import Foundation

struct RWArticle: Codable {
    struct Data: Codable {
        let id: String
        let type: String
        let attributes: [String: Attribute]
        let relationships: [String: Relationship]
        let links: String?
        
        struct Attribute: Codable {
            let uri: String
            let name: String
            let description: String
            let released_at: String
            let free: Bool
            let difficulty: String
            let content_type: String
            let duration: Int
            let popularity: Int
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
            let domains: [String: [Domain]]
            let childContents: Meta
            let progression: ProgressionData
            let bookmark: BookmarkData
            
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
}

