//
//  Article.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/13/22.
//

import Foundation

struct ResourceData: Decodable {
    let data: [Resource]
}

struct Resource: Decodable {
    let id: String
    let type: String
    let attributes: Attributes
    //let links: Links
}

struct Attributes: Decodable {
    let uri: String
    let name: String
    let description: String
    let released_at: String
    let free: Bool
    let difficulty: Difficulty?
    let content_type: ContentType
    let duration: Int
    let popularity: Float
    let technology_triple_string: String
    let contributor_string: String
    let ordinal: String?
    let professional: Bool
    let description_plain_text: String
    let video_identifier: String?
    let parent_name: String?
    let card_artwork_url: String
}

struct Links: Decodable {
    let `self`: String
}

enum Difficulty: String, Decodable {
    case beginner, intermediate, advanced
}

enum ContentType: String, Decodable {
    case article, collection
}
