import Foundation

enum CourseType: String {
    case article
    case collection

    var asString: String {
        switch self {
        case .article:
            return "Article"
        case .collection:
            return "Video"
        }
    }
}
