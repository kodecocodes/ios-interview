import Foundation

extension Array where Element == CourseFilter {
    // MARK: - Public Properties

    func containsType(_ type: CourseFilter) -> Bool {
        !filter {
            switch $0 {
            case type:
                return true
            default:
                return false
            }
        }.isEmpty
    }
}
