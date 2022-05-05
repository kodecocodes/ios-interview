import UIKit

class SearchBarTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var textfield: UITextField!
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Public properties

    var viewModel: SearchBarTableViewCellViewModelProtocol? {
        didSet {
            setup()
        }
    }

    // MARK: - Setup Methods

    private func setup() {
        setupTextfield()
    }

    private func setupTextfield() {
        textfield.delegate = self
        textfield.returnKeyType = .search
        textfield.autocapitalizationType = .sentences
        textfield.backgroundColor = .backgroundSecondaryDark
        textfield.attributedPlaceholder = viewModel?.textfieldPlaceholder
        
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1.5
        textfield.layer.borderColor = UIColor.textBlueGray.cgColor
        textfield.setLeftPaddingPoints(10)
        
        textfield.addTarget(
            self,
            action: #selector(textFieldDidChange),
            for: .editingChanged)
    }

    // MARK: - Callbacks

    @objc func textFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }

        viewModel?.textfieldUpdatedText(text)
    }

    @IBAction func filtersButtonTapped(_ sender: Any) {
        viewModel?.filtersButtonTapped()
    }
}

// MARK: - UITextFieldDelegate

extension SearchBarTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
