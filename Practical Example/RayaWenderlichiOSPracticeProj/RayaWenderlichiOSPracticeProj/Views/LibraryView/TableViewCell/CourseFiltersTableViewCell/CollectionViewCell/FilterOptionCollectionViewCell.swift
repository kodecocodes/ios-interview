import UIKit

class FilterOptionCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeImageView: UIImageView!
    
    // MARK: - Public Properties

    var viewModel: FilterOptionCollectionViewCellViewModelProtocol? {
        didSet {
            setup()
        }
    }

    // MARK: - Setup Methods

    private func setup() {
        setupSubviews()
        stylizeView()
    }

    private func setupSubviews() {
        titleLabel.text = viewModel?.title
    }

    private func stylizeView() {
        cellBackgroundView.layer.cornerRadius = 10
        cellBackgroundView.clipsToBounds = true

        if viewModel?.filterType == .destructive {
            titleLabel.textColor = .white
            cellBackgroundView.backgroundColor = .destructiveRed
            closeImageView.image = UIImage(named: "closeWhite")
        } else {
            titleLabel.textColor = .textOffWhite
            cellBackgroundView.backgroundColor = .backgroundSecondaryDark
            closeImageView.image = UIImage(named: "close")
        }
    }
}
