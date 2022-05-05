import Foundation

protocol SortStyleTableViewCellViewModelProtocol {
    var title: String { get }
    var sortStyle: String { get }
    var delegate: SortStyleTableViewCellViewModelDelegate? { get set }

    func sortStyleButtonTapped()
}

protocol SortStyleTableViewCellViewModelDelegate: AnyObject {
    func sortStyleTableViewCellViewModelSortStyleButtonTapped(
        _ sortStyleTableViewCellViewModel: SortStyleTableViewCellViewModelProtocol
    )
}

enum CourseSortStyle: String, Hashable {
    case newest
    case oldest
}

class SortStyleTableViewCellViewModel: SortStyleTableViewCellViewModelProtocol {
    // MARK: - Init

    init(
        title: String,
        sortStyle: CourseSortStyle,
        delegate: SortStyleTableViewCellViewModelDelegate? = nil
    ) {
        self.title = title
        self.sortStyle = sortStyle.rawValue.localizedCapitalized
        self.delegate = delegate
    }

    // MARK: - Public Properties

    var title: String

    var sortStyle: String

    weak var delegate: SortStyleTableViewCellViewModelDelegate?

    // MARK: - Public Methods

    func sortStyleButtonTapped() {
        delegate?.sortStyleTableViewCellViewModelSortStyleButtonTapped(self)
    }
}
