import Foundation

extension Date {
    // MARK: - Public properties

    var formatToMediumDateStyle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }

    // MARK: - Public Methods

    func isSoonerThan(_ date: Date) -> Bool {
        self > date
    }
}
