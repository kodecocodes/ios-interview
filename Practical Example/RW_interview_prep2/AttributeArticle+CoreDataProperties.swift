//
//  AttributeArticle+CoreDataProperties.swift
//  RW_interview_prep
//
//  Created by Duc Dang on 8/31/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//
//

import Foundation
import CoreData


extension AttributeArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttributeArticle> {
        return NSFetchRequest<AttributeArticle>(entityName: "AttributeArticle")
    }

    @NSManaged public var card_artwork_url: String?
    @NSManaged public var content_type: String?
    @NSManaged public var contributor_string: String?
    @NSManaged public var description_plain_text: String?
    @NSManaged public var descriptionn: String?
    @NSManaged public var difficulty: String?
    @NSManaged public var duration: Int16
    @NSManaged public var free: Bool
    @NSManaged public var name: String?
    @NSManaged public var popularity: Int16
    @NSManaged public var released_at: String?
    @NSManaged public var technology_triple_string: String?
    @NSManaged public var uri: String?
    @NSManaged public var id: UUID?

    public var wrapperCard_artwork_url : String {
        card_artwork_url ?? "Unknown"
    }
    
    public var wrapperContent_type : String {
        content_type ?? "Unknown"
    }
    
    public var wrapperContributor_string : String {
        contributor_string ?? "Unknown"
    }
    
    public var wrapperDescription_plain_text : String {
        description_plain_text ?? "Unknown"
    }
    
    public var wrapperDescriptionn : String {
        descriptionn ?? "Unknown"
    }
    
    public var wrapperDifficulty : String {
        difficulty ?? "Unknown"
    }
    
    public var wrapperDuration : Int16 {
        duration
    }
    
    public var wrapperFree : Bool {
        free
    }
    
    public var wrapperName : String {
        name ?? "Unknown"
    }
    
    public var wrapperPopularity : Int16 {
        popularity
    }
    
    public var wrapperReleased_at : String {
        released_at ?? "Unknown"
    }
    
    public var wrapperTechnology_triple_string : String {
        technology_triple_string ?? "Unknown"
    }
    
    public var wrapperUri : String {
        uri ?? "Unknown"
    }
}
