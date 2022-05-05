import UIKit
import Kingfisher

class LibraryViewTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var miscInfoLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var proBadgeBackgroundView: UIView!
    @IBOutlet weak var proBadgeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Private properties

    var viewModel: LibraryViewTableViewCellViewModelProtocol? {
        didSet {
            setup()
        }
    }

    // MARK: - Setup methods

    private func setup() {
        stylizeView()
        setupSubviews()
    }

    private func stylizeView() {
        contentView.backgroundColor = .clear
        stylizeBackgroundView()
        stylizeProBadge()
    }

    private func setupSubviews() {
        proBadgeBackgroundView.isHidden = viewModel?.proBadgeHidden ?? false
        setLabels()
    }

    private func setLabels() {
        setupTitleLabel()
        setupPlatformLabel()
        setupDescriptionLabel()
        setupArtworkImageView()
        setupMiscInfoLabel()
    }

    private func stylizeBackgroundView() {
        cellBackgroundView.backgroundColor = .backgroundSecondaryDark
        cellBackgroundView.layer.cornerRadius = 15
    }

    private func stylizeProBadge() {
        proBadgeBackgroundView.backgroundColor = .proBadgeBlue
        proBadgeBackgroundView.layer.cornerRadius = 7.5
        
    }

    private func setupTitleLabel() {
        courseTitleLabel.text = viewModel?.courseTitle
        courseTitleLabel.textColor = .textOffWhite
    }

    private func setupPlatformLabel() {
        platformLabel.text = viewModel?.platform
        platformLabel.textColor = .textBlueGray
    }

    private func setupDescriptionLabel() {
        descriptionLabel.text = viewModel?.descriptionText
        descriptionLabel.textColor = .textBlueGray
    }

    private func setupArtworkImageView() {
        let processor = RoundCornerImageProcessor(cornerRadius: 75) // why so high?
        artworkImageView.kf.setImage(
            with: viewModel?.artworkURL,
            options: [.processor(processor)])
    }

    private func setupMiscInfoLabel() {
        miscInfoLabel.text = viewModel?.miscInfoText
        miscInfoLabel.textColor = .textBlueGray
    }
}
