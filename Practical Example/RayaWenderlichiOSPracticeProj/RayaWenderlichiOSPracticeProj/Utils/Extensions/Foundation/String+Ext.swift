import Foundation

extension String {
    // MARK: - Public Methods

    func containsRootSubstring(
        _ substr: String,
        ignoreExactMatch: Bool = false
    ) -> Bool {
        if self == substr && ignoreExactMatch {
            return false
        }

        let substrRangeLoc = (self as NSString)
            .localizedStandardRange(of: substr)
            .location

        return substrRangeLoc == 0
    }
}
