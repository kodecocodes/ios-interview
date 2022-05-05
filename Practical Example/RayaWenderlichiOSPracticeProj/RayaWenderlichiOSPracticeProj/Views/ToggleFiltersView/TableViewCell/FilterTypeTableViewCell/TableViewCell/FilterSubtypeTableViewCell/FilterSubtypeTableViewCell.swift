import UIKit

class FilterSubtypeTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioButtonImageView: UIImageView!
    @IBOutlet weak var radioButtonView: UIView!
    @IBOutlet weak var radioButton: UIButton!
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Public Properties
    
    var viewModel: FilterSubtypeTableViewCellViewModelProtocol? {
        didSet {
            setup()
        }
    }

    // MARK: - Setup Methods
    
    private func setup() {
        setupTitleLabel()
        setupRadioButtonView()
    }

    private func setupTitleLabel() {
        titleLabel.text = viewModel?.title
        titleLabel.textColor = .textOffWhite
    }

    private func setupRadioButtonView() {
        radioButtonView.layer.cornerRadius = 8
        radioButtonView.layer.borderWidth = 1.5

        if viewModel?.isSelected ?? false {
            radioButtonImageView.isHidden = false
            radioButtonView.backgroundColor = .wenderlichOffGreen
            radioButtonView.layer.borderColor = UIColor.wenderlichOffGreen.cgColor
        } else {
            radioButtonImageView.isHidden = true
            radioButtonView.backgroundColor = .clear
            radioButtonView.layer.borderColor = UIColor.textBlueGray.cgColor
        }        
    }

    // MARK: - Callbacks

    @IBAction func radioButtonTapped(_ sender: Any) {
        viewModel?.radioButtonTapped()
        UIImpactFeedbackGenerator.generate(style: .medium)
    }
}
