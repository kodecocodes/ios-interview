import UIKit

extension UIStoryboard {
    // MARK: - Public Static Methods

    static func instantiateTypedVC<T: UIViewController>() -> T? {
        let identifier = String(describing: T.self)
            .replacingOccurrences(of: "Controller", with: "")

        return UIStoryboard(name: identifier, bundle: nil)
            .instantiateViewController(identifier: identifier)
        as? T
    }
}
