import Foundation

extension Array where Element == CourseInfo {
    // MARK: - Public Methods

    func sorted(
        by sortStyle: CourseSortStyle
    ) -> [CourseInfo] {
        sorted {
            guard
                let releaseDate0 = $0.releaseDate,
                let releaseDate1 = $1.releaseDate
            else {
                return false
            }

            return sortStyle == .newest ?
                releaseDate0.isSoonerThan(releaseDate1) :
                !releaseDate0.isSoonerThan(releaseDate1)
        }
    }

    func filtered(
        by filters: Set<CourseFilter>
    ) -> [CourseInfo] {
        guard !filters.isEmpty else {
            return self
        }

        return filter { courseInfo in
            var isIncludedArr = [Bool]()
            filters.forEach { courseFilter in
                switch courseFilter {
                case let .contentType(contentType):
                    switch contentType {
                    case .article:
                        isIncludedArr.append(courseInfo.courseType == .article)
                    case .video:
                        isIncludedArr.append(courseInfo.courseType == .collection)
                    case .none:
                        isIncludedArr.append(false)
                    }
                case let .domain(domain):
                    isIncludedArr.append(courseInfo.domain == domain)
                case let .subscriptionType(subscriptionType):
                    switch subscriptionType {
                    case .professional:
                        isIncludedArr.append(courseInfo.isProfessional ?? false)
                    case .none:
                        isIncludedArr.append(false)
                    }
                }
            }
            
            return isIncludedArr.contains(true)
        }
    }

    func filterOnQuery(_ query: String) -> [CourseInfo] {
        guard !query.isEmpty else {
            return self
        }

        return compactFilter {
            $0.title?.containsRootSubstring(query)
        }
    }
}
