//
//  RWResponse.swift
//  RWContent
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import Foundation

struct RWResponse: Codable {
    let data: [RWArticle]
    let included: [Included]
    let links: Link?
    let meta: Meta
    
    struct Included: Codable {
        let id: String
        let type: String
        let attributes: IncludedAttribute
        
        struct IncludedAttribute: Codable {
            let name: String
            let slug: String
            let description: String
            let level: String
            let ordinal: Int
        }
    }
    
    struct Link: Codable {
        var current: String
        var first: String
        var previous: String?
        var next: String
        var last: String
        
        enum CodingKeys: String, CodingKey {
            case current = "self"
            case first
            case previous = "prev"
            case next
            case last
        }
    }
    
    struct Meta: Codable {
        let totalResultCount: Int?
    }
}
