import Foundation
import UIKit

protocol SearchBarTableViewCellViewModelProtocol {
    var textfieldPlaceholder: NSAttributedString { get }
    var delegate: SearchBarTableViewCellViewModelDelegate? { get set }
    
    func textfieldUpdatedText(_ text: String)
    func filtersButtonTapped()
}

protocol SearchBarTableViewCellViewModelDelegate: AnyObject {
    func searchBarTableViewCellViewModel(
        _ searchBarTableViewCellViewModel: SearchBarTableViewCellViewModelProtocol,
        searchQueryUpdated query: String
    )

    func searchBarTableViewCellViewModelFiltersButtonTapped(
        _ searchBarTableViewCellViewModel: SearchBarTableViewCellViewModelProtocol
    )
}

class SearchBarTableViewCellViewModel: SearchBarTableViewCellViewModelProtocol {
    // MARK: - Init
    
    init(delegate: SearchBarTableViewCellViewModelDelegate? = nil) {
        self.delegate = delegate
    }

    // MARK: - Public Properties

    var textfieldPlaceholder: NSAttributedString = NSAttributedString(
        string: "Search",
        attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)])

    weak var delegate: SearchBarTableViewCellViewModelDelegate?

    // MARK: - Public Methods

    func textfieldUpdatedText(_ text: String) {
        delegate?.searchBarTableViewCellViewModel(self, searchQueryUpdated: text)
    }

    func filtersButtonTapped() {
        delegate?.searchBarTableViewCellViewModelFiltersButtonTapped(self)
    }
}
