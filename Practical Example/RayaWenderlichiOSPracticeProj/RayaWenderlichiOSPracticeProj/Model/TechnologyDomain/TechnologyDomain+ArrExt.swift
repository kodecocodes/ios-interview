import Foundation

extension Array where Element == TechnologyDomain {
    // MARK: - Public Properties

    var mappedToCourseFilters: [CourseFilter] {
        map { CourseFilter.domain($0) }
    }
}
