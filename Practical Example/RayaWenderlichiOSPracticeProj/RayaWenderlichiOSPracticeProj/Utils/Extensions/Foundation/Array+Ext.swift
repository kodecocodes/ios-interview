import Foundation

extension Array {
    // MARK: - Public Methods

    func compactFilter(_ isIncluded: (Element) -> Bool?) -> [Element] {
        filter { isIncluded($0) ?? false }
    }
}
