import Foundation
import UIKit

protocol FilterTypeTableViewCellViewModelProtocol {
    var title: String? { get }
    var subtitle: String? { get }
    var rowHeight: CGFloat { get }
    var collapseArrowImage: UIImage? { get }
    var delegate: FilterTypeTableViewCellViewModelDelegate? { get set }

    func numberOfRowsInSection(_ section: Int) -> Int
    func getFilterSubtypeTableViewCellViewModel(at indexPath: IndexPath) -> FilterSubtypeTableViewCellViewModelProtocol
    func cellBackgroundViewButtonTapped()
}

protocol FilterTypeTableViewCellViewModelDelegate: AnyObject {
    func filterTypeTableViewCellViewModelFilterOptionToggled(
        _ filterTypeTableViewCellViewModel: FilterTypeTableViewCellViewModelProtocol,
        filter: CourseFilter
    )

    func filterTypeTableViewCellViewModelFilterViewTapped(
        _ filterTypeTableViewCellViewModel: FilterTypeTableViewCellViewModelProtocol,
        filter: CourseFilter
    )
}

class FilterTypeTableViewCellViewModel: FilterTypeTableViewCellViewModelProtocol {
    // MARK: - Init

    init(
        filterData: ToggleFiltersViewModelProtocol.FilterTypeData,
        expanded: Bool,
        delegate: FilterTypeTableViewCellViewModelDelegate? = nil
    ) {
        self.filterData = filterData
        self.expanded = expanded
        self.delegate = delegate
    }

    // MARK: - Private Properties

    private var filterData: ToggleFiltersViewModelProtocol.FilterTypeData

    private var expanded: Bool

    // MARK: - Public Properties

    var title: String? {
        filterData.filterType.typeName
    }
    
    var subtitle: String? {
        let count = filterData.filterSubtypeData.selectedCount
        return count == 0 ? nil : "\(count)"
    }

    var rowHeight: CGFloat = 44

    var collapseArrowImage: UIImage? {
        let imageName = expanded ? "downArrowBlueGray" : "arrowRightBlueGray"
        return UIImage(named: imageName)
    }

    weak var delegate: FilterTypeTableViewCellViewModelDelegate?

    // MARK: - Public Methods
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        filterData.filterSubtypeData.count
    }

    func getFilterSubtypeTableViewCellViewModel(
        at indexPath: IndexPath
    ) -> FilterSubtypeTableViewCellViewModelProtocol {
        let subtypeData = filterData.filterSubtypeData[indexPath.row]
        return FilterSubtypeTableViewCellViewModel(
            subtype: subtypeData.filter,
            isSelected: subtypeData.isSelected,
            delegate: self)
    }

    func cellBackgroundViewButtonTapped() {
        delegate?.filterTypeTableViewCellViewModelFilterViewTapped(
            self,
            filter: filterData.filterType)
    }
}

// MARK: - FilterSubtypeTableViewCellViewModelDelegate

extension FilterTypeTableViewCellViewModel: FilterSubtypeTableViewCellViewModelDelegate {
    func filterSubtypeTableViewCellViewModelRadioButtonTapped(
        _ filterSubtypeTableViewCellViewModel: FilterSubtypeTableViewCellViewModelProtocol,
        subtype filter: CourseFilter
    ) {
        delegate?.filterTypeTableViewCellViewModelFilterOptionToggled(
            self,
            filter: filter)
    }
}
