import Foundation
import UIKit

protocol CourseFiltersTableViewCellViewModelProtocol {
    typealias DataSourceElement = (filterName: String?, filterType: FilterType)
    var dataSource: [DataSourceElement] { get set }
    var delegate: CourseFiltersTableViewCellViewModelDelegate? { get set }

    func numberOfRowsInSection(_ section: Int) -> Int
    func getItemWidth(at indexPath: IndexPath) -> CGFloat?
    func itemSelected(at indexPath: IndexPath)
    func getFilterOptionCollectionViewCellViewModel(at indexPath: IndexPath) -> FilterOptionCollectionViewCellViewModel
}

protocol CourseFiltersTableViewCellViewModelDelegate: AnyObject {
    func courseFiltersTableViewCellViewModel(
        _ courseFiltersTableViewCellViewModel: CourseFiltersTableViewCellViewModelProtocol,
        filterShouldBeRemoved filter: CourseFilter
    )

    func courseFiltersTableViewCellViewModelRemoveAllActiveFilters(
        _ courseFiltersTableViewCellViewModel: CourseFiltersTableViewCellViewModelProtocol
    )
}

class CourseFiltersTableViewCellViewModel: CourseFiltersTableViewCellViewModelProtocol {
    // MARK: - Init

    init(
        filters: Set<CourseFilter>,
        delegate: CourseFiltersTableViewCellViewModelDelegate? = nil
    ) {
        self.filters = filters
        setupDataSource(filters: filters)
        self.delegate = delegate
    }

    private var filters: Set<CourseFilter>

    private let clearAllOptionTitle = "Clear All"

    // MARK: - Public Properties
    
    var dataSource: [DataSourceElement] = []

    weak var delegate: CourseFiltersTableViewCellViewModelDelegate?

    // MARK: - Public Methods

    func numberOfRowsInSection(_ section: Int) -> Int {
        dataSource.count
    }

    func getItemWidth(at indexPath: IndexPath) -> CGFloat? {
        let text = dataSource[indexPath.row].filterName
        return (text?
            .size(withAttributes: [.font : UIFont.systemFont(ofSize: 13)])
            .width ?? 75) + 60
    }

    func itemSelected(at indexPath: IndexPath) {
        let filterName = dataSource[indexPath.row].filterName
        if let filter = filters.first(where: { $0.subtypeName == filterName }) {
            delegate?.courseFiltersTableViewCellViewModel(self, filterShouldBeRemoved: filter)
        } else if filterName == clearAllOptionTitle {
            delegate?.courseFiltersTableViewCellViewModelRemoveAllActiveFilters(self)
        }
    }

    func getFilterOptionCollectionViewCellViewModel(
        at indexPath: IndexPath
    ) -> FilterOptionCollectionViewCellViewModel {
        let rowInfo = dataSource[indexPath.row]
        return FilterOptionCollectionViewCellViewModel(
            filterName: rowInfo.filterName,
            filterType: rowInfo.filterType)
    }

    private func getFilterTitle(
        for filter: CourseFilter
    ) -> String? {
        switch filter {
        case let .contentType(contentType):
            return contentType?.nameStr
        case let .domain(technologyDomain):
            return technologyDomain?.name
        case let .subscriptionType(subscriptionType):
            return subscriptionType?.nameStr
        }
    }
    
    // MARK: - Private Methods
    
    private func setupDataSource(filters: Set<CourseFilter>) {
        guard !filters.isEmpty else {
            return
        }

        if filters.count > 1 {
            dataSource.append((clearAllOptionTitle, .destructive))
        }

        let mappedFilters = filters.map { ($0.subtypeName, FilterType.normal) }
        dataSource.append(contentsOf: mappedFilters)
    }
}
