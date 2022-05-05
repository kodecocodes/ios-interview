import Foundation

struct CourseInfo: Hashable {
    var title: String?
    var domain: TechnologyDomain?
    var artworkURL: String?
    var description: String?
    var releaseDate: Date?
    var duration: TimeInterval?
    var courseType: CourseType?
    var isProfessional: Bool?
    
    init(
        title: String? = nil,
        domain: TechnologyDomain? = nil,
        artworkURL: String? = nil,
        description: String? = nil,
        releaseDate: Date? = nil,
        duration: TimeInterval? = nil,
        courseType: CourseType? = nil,
        professional: Bool? = nil
    ) {
        self.title = title
        self.domain = domain
        self.artworkURL = artworkURL
        self.description = description
        self.releaseDate = releaseDate
        self.duration = duration
        self.courseType = courseType
        self.isProfessional = professional
    }

    init(
        _ dataStruct: GithubResponseBody.DataStruct,
        domains: [TechnologyDomain]?
    ) {
        let attributes = dataStruct.attributes

        title = attributes?.name
        description = attributes?.description_plain_text
        artworkURL = attributes?.card_artwork_url
        duration = attributes?.duration
        isProfessional = attributes?.professional
        
        if let includedDomains = dataStruct.relationships?.domains.data {
            let matchedDomain = domains?.first { $0.id == includedDomains.first?.id }
            domain = matchedDomain
        }

        if let releasedAt = attributes?.released_at {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: releasedAt)
            releaseDate = date
        }
        
        if let contentType = attributes?.content_type {
            courseType = CourseType.init(rawValue: contentType)
        }
    }
}
