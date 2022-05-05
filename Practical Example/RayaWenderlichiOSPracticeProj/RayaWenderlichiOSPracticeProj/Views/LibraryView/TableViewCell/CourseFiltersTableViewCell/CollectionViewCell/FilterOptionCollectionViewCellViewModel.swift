import Foundation

protocol FilterOptionCollectionViewCellViewModelProtocol {
    var title: String? { get set }
    var filterType: FilterType { get set }
}

enum FilterType {
    case normal
    case destructive
}

class FilterOptionCollectionViewCellViewModel: FilterOptionCollectionViewCellViewModelProtocol {
    // MARK: - Init

    init(
        filterName: String?,
        filterType: FilterType
    ) {
        self.title = filterName
        self.filterType = filterType
    }

    // MARK: - Public Properties

    var title: String?
    
    var filterType: FilterType
}
