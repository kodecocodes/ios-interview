import UIKit

extension UICollectionView {
    // MARK: - Public Methods

    func registerCell(
        ofType cellType: UICollectionViewCell.Type
    ) {
        let name = String(describing: cellType.self)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: name)
    }

    func dequeueTypedCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        dequeueReusableCell(
            withReuseIdentifier: String(describing: T.self),
            for: indexPath) as! T // swiftlint:disable:this force_cast
    }
}
