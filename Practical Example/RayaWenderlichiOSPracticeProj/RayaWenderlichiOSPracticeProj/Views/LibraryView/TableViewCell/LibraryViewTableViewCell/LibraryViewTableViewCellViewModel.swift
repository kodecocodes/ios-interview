import Foundation
import UIKit

protocol LibraryViewTableViewCellViewModelProtocol {
    var courseTitle: String? { get }
    var platform: String? { get }
    var descriptionText: String? { get }
    var artworkURL: URL? { get }
    var proBadgeHidden: Bool { get }
    var miscInfoText: String? { get }
}

class LibraryViewTableViewCellViewModel: LibraryViewTableViewCellViewModelProtocol {
    // MARK: - Init

    init(courseInfo: CourseInfo) {
        self.courseInfo = courseInfo
    }

    // MARK: - Private propeties

    private let courseInfo: CourseInfo

    // MARK: - Public Properties

    var courseTitle: String? {
        courseInfo.title
    }

    var platform: String? {
        courseInfo.domain?.name
    }

    var descriptionText: String? {
        courseInfo.description
    }

    var artworkURL: URL? {
        if let url = courseInfo.artworkURL {
            return URL(string: url)
        }

        return nil
    }

    var proBadgeHidden: Bool {
        !(courseInfo.isProfessional ?? false)
    }

    var miscInfoText: String? {
        var str = ""

        if let releaseDate = courseInfo.releaseDate {
            str += releaseDate.formatToMediumDateStyle
        }
        
        if courseInfo.courseType != nil || courseInfo.duration?.abbreviatedTimeStr != nil {
            str += " •"
        }
        if let courseType = courseInfo.courseType {
            str += " \(courseType.asString.localizedCapitalized) Course"
        }
        
        if let duration = courseInfo.duration, let durationString = duration.abbreviatedTimeStr {
            str += " (\(durationString))"
        }

        return str
    }
}
