import Foundation

struct GithubResponseBody: Codable {
    var data: [DataStruct]?
    var included: [Included]?

    struct DataStruct: Codable {
        var id: String?
        var contents: String?
        var attributes: DataAttributes?
        var relationships: Relationships?

        struct DataAttributes: Codable {
            var uri: String?
            var name: String?
            var description_plain_text: String?
            var released_at: String?
            var professional: Bool?
            var difficulty: String?
            var content_type: String?
            var duration: TimeInterval?
            var technology_triple_string: String?
            var contributor_string: String?
            var card_artwork_url: String?
        }
        
        struct Relationships: Codable {
            var domains: Domains
            
            struct Domains: Codable {
                var data: [DomainsData]?
                
                struct DomainsData: Codable {
                    var id: String?
                    var type: String?
                }
            }
        }
    }
    
    struct Included: Codable {
        var id: String?
        var type: String?
        var attributes: IncludedAttributes?
        
        struct IncludedAttributes: Codable {
            var name: String?
        }
    }
}
