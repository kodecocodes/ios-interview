import UIKit

extension UITableView {
    // MARK: - Public Methods

    func registerCell(
        ofType cellType: UITableViewCell.Type
    ) {
        let name = String(describing: cellType.self)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: name)
    }

    func dequeueTypedCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        dequeueReusableCell(
            withIdentifier: String(describing: T.self),
            for: indexPath) as! T
    }

    func setEmptyStateMessage(_ message: String) {
        let messageLabel = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: bounds.size.width,
                height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .textOffWhite
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        backgroundView = messageLabel
    }
}
