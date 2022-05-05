import UIKit

class SortStyleTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var sortStyleLabel: UILabel!

    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Public Properties

    var viewModel: SortStyleTableViewCellViewModelProtocol? {
        didSet {
            setup()
        }
    }

    // MARK: - Setup Methods

    private func setup() {
        setupLabels()
    }

    private func setupLabels() {
        setupTitleLabel()
        setupSortStyleLabel()
    }

    private func setupTitleLabel() {
        titleLabel.text = viewModel?.title
        titleLabel.textColor = .textOffWhite
    }

    private func setupSortStyleLabel() {
        sortStyleLabel.text = viewModel?.sortStyle
        sortStyleLabel.textColor = .textOffWhite
    }

    // MARK: - Callbacks
    
    @IBAction func sortStyleButtonTapped(_ sender: Any) {
        viewModel?.sortStyleButtonTapped()
    }
}
