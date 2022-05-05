import Foundation
import UIKit

protocol ToggleFiltersViewModelProtocol {
    typealias FilterSubtypeData = (filter: CourseFilter, isSelected: Bool)
    typealias FilterTypeData = (
        filterType: CourseFilter,
        filterSubtypeData: [FilterSubtypeData])
    typealias DataSourceElement = (filterData: FilterTypeData, expanded: Bool)
    
    var title: String { get }
    var dataSource: [(filterData: FilterTypeData, expanded: Bool)] { get set }
    var delegate: ToggleFiltersViewModelDelegate? { get set }
    var viewControllerDelegate: ToggleFiltersViewModelViewControllerDelegate? { get set }

    func numberOfRowsInSection(_ section: Int) -> Int
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func getFilterTypeTableViewCellViewModel(at indexPath: IndexPath) -> FilterTypeTableViewCellViewModelProtocol
    
    func clearAllButtonTapped()
    func applyButtonTapped()
}

protocol ToggleFiltersViewModelDelegate: AnyObject {
    func toggleFiltersViewModel(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol,
        activeFitlersUpdated: Set<CourseFilter>
    )
}

protocol ToggleFiltersViewModelViewControllerDelegate: AnyObject {
    func toggleFiltersViewModelReloadTableView(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol
    )

    func toggleFiltersViewModelUpdateTableView(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol,
        completion: @escaping () -> Void
    )

    func toggleFiltersViewModelDismissSelf(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol
    )
}

class ToggleFiltersViewModel: ToggleFiltersViewModelProtocol {
    // MARK: - Init
    
    init(
        activeFilters: Set<CourseFilter>,
        technologyDomains: [TechnologyDomain],
        delegate: ToggleFiltersViewModelDelegate? = nil
    ) {
        self.activeFilters = activeFilters
        self.technologyDomains = technologyDomains
        self.delegate = delegate
        setupDataSource()
    }

    // MARK: - Private Properties

    private var activeFilters: Set<CourseFilter>

    private var technologyDomains: [TechnologyDomain]

    private var baseRowHeight: CGFloat = 66.5

    private var subtypeIndRowHeight: CGFloat = 44

    private var domainExpanded = true

    private var contentTypeExpanded = true

    private var subscriptionTypeExpanded = true

    // MARK: - Public Properties

    var title: String = "Filters"

    var dataSource = [DataSourceElement]()

    weak var delegate: ToggleFiltersViewModelDelegate?

    weak var viewControllerDelegate: ToggleFiltersViewModelViewControllerDelegate?

    // MARK: - Public Methods
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        dataSource.count
    }

    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        let filterType = dataSource[indexPath.row].filterData.filterType
        let subtypeCount = dataSource[indexPath.row].filterData.filterSubtypeData.count
        let isExpanded = isExpanded(filterType)

        return baseRowHeight + (isExpanded ? (subtypeIndRowHeight * CGFloat(subtypeCount)) : 0)
    }

    private func isExpanded(_ filterType: CourseFilter) -> Bool {
        switch filterType {
        case .contentType:
            return contentTypeExpanded
        case .domain:
            return domainExpanded
        case .subscriptionType:
            return subscriptionTypeExpanded
        }
    }

    func getFilterTypeTableViewCellViewModel(
        at indexPath: IndexPath
    ) -> FilterTypeTableViewCellViewModelProtocol {
        let filterData = dataSource[indexPath.row].filterData
        let expanded = dataSource[indexPath.row].expanded

        return FilterTypeTableViewCellViewModel(
            filterData: filterData,
            expanded: expanded,
            delegate: self)
    }

    func clearAllButtonTapped() {
        activeFilters.removeAll()
        delegate?.toggleFiltersViewModel(self, activeFitlersUpdated: activeFilters)
        
        setupDataSource()
        viewControllerDelegate?.toggleFiltersViewModelReloadTableView(self)
    }

    func applyButtonTapped() {
        delegate?.toggleFiltersViewModel(self, activeFitlersUpdated: activeFilters)
        viewControllerDelegate?.toggleFiltersViewModelDismissSelf(self)
    }

    // MARK: - Private Methods

    private func setupDataSource() {
        let contentTypeFilters = mapContentTypeFilters()
        let subscriptionFilters = mapSubscriptionTypeFilters()
        let domainFilters = mapDomainTypeFilters()
        dataSource =
            [
                ((.domain(), domainFilters), domainExpanded),
                ((.contentType(), contentTypeFilters), contentTypeExpanded),
                ((.subscriptionType(), subscriptionFilters), subscriptionTypeExpanded),
            ]
    }

    private func mapContentTypeFilters() -> [FilterSubtypeData] {
        let contentTypeFilters = [CourseFilter.contentType(.article), CourseFilter.contentType(.video)]
        return contentTypeFilters.map {
            var isSelected = false
            switch $0 {
            case .contentType:
                isSelected = activeFilters.contains($0)
            case .domain, .subscriptionType:
                isSelected = false
            }
            
            return (filter: $0, isSelected: isSelected)
        }
    }

    private func mapSubscriptionTypeFilters() -> [FilterSubtypeData] {
        let subscriptionFilter = [CourseFilter.subscriptionType(.professional)]
        return subscriptionFilter.map {
            var isSelected = false
            switch $0 {
            case .subscriptionType:
                isSelected = activeFilters.contains($0)
            case .domain, .contentType:
                isSelected = false
            }
            
            return (filter: $0, isSelected: isSelected)
        }
    }

    private func mapDomainTypeFilters() -> [FilterSubtypeData] {
        let domainFilters = technologyDomains.mappedToCourseFilters
        return domainFilters.map {
            var isSelected = false
            switch $0 {
            case .domain:
                isSelected = activeFilters.contains($0)
            case .subscriptionType, .contentType:
                isSelected = false
            }
            
            return (filter: $0, isSelected: isSelected)
        }
    }
}

// MARK: - FilterTypeTableViewCellViewModelDelegate

extension ToggleFiltersViewModel: FilterTypeTableViewCellViewModelDelegate {
    func filterTypeTableViewCellViewModelFilterOptionToggled(
        _ filterTypeTableViewCellViewModel: FilterTypeTableViewCellViewModelProtocol,
        filter: CourseFilter
    ) {
        if let index = activeFilters.firstIndex(of: filter) {
            activeFilters.remove(at: index)
        } else {
            activeFilters.insert(filter)
        }

        setupDataSource()
        viewControllerDelegate?.toggleFiltersViewModelReloadTableView(self)
    }

    func filterTypeTableViewCellViewModelFilterViewTapped(
        _ filterTypeTableViewCellViewModel: FilterTypeTableViewCellViewModelProtocol,
        filter: CourseFilter
    ) {
        switch filter {
        case .contentType:
            contentTypeExpanded.toggle()
        case .domain:
            domainExpanded.toggle()
        case .subscriptionType:
            subscriptionTypeExpanded.toggle()
        }

        setupDataSource()
        viewControllerDelegate?.toggleFiltersViewModelUpdateTableView(self) {
            self.viewControllerDelegate?.toggleFiltersViewModelReloadTableView(self)
        }
    }
}

// MARK: - Local Extension

extension Array where Element == ToggleFiltersViewModelProtocol.FilterSubtypeData {
    var selectedCount: Int {
        reduce(0) { $0 + ($1.isSelected ? 1 : 0) }
    }
}
