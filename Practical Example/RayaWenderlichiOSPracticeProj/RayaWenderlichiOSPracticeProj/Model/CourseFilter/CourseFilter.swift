import Foundation

enum CourseFilter: Equatable, Hashable {
    case contentType(CourseContentType? = nil)
    case domain(TechnologyDomain? = nil)
    case subscriptionType(SubscriptionType? = nil)

    var typeName: String? {
        switch self {
        case .contentType:
            return "Content Type"
        case .domain:
            return "Platforms"
        case .subscriptionType:
            return "Subscription Plans"
        }
    }

    var subtypeName: String? {
        switch self {
        case let .contentType(contentType):
            return contentType?.nameStr
        case let .domain(domain):
            return domain?.name
        case let .subscriptionType(subscriptionType):
            return subscriptionType?.nameStr
        }
    }

    var subtypes: [CourseFilter] {
        switch self {
        case .domain:
            return []
        case .contentType:
            return [CourseFilter.contentType(.article), CourseFilter.contentType(.video)]
        case .subscriptionType:
            return [CourseFilter.subscriptionType(.professional)]
        }
    }
}

enum CourseContentType: Equatable, Hashable {
    case article
    case video

    var nameStr: String? {
        switch self {
        case .article:
            return "Article Course"
        case .video:
            return "Video Course"
        }
    }
}

enum SubscriptionType: Equatable, Hashable {
    case professional

    var nameStr: String? {
        switch self {
        case .professional:
            return "Pro"
        }
    }
}
