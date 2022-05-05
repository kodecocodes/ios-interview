import Foundation

extension TimeInterval {
    // MARK: - Public properties

    var abbreviatedTimeStr: String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        return formatter.string(from: self)
    }
}
