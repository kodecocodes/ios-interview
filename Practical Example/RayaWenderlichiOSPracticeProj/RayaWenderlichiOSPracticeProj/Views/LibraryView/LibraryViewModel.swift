import Foundation
import UIKit

protocol LibraryViewModelProtocol {
    var title: String { get }
    var dataSource: [LibraryViewRowType] { get }
    var numberOfSections: Int { get }
    var estimatedRowHeight: CGFloat { get }
    var viewControllerDelegate: LibraryViewModelViewControllerDelegate? { get set }

    func numberOfRowsInSection(_ section: Int) -> Int
    func getSearchBarTableViewCellViewModel() -> SearchBarTableViewCellViewModelProtocol
    func getCourseFiltersTableViewCellViewModel() -> CourseFiltersTableViewCellViewModelProtocol
    func getSortStyleTableViewCellViewModel() -> SortStyleTableViewCellViewModelProtocol
    func getLibraryViewTableViewCellViewModel(at indexPath: IndexPath) -> LibraryViewTableViewCellViewModelProtocol?
    
    func getToggleFiltersViewModel() -> ToggleFiltersViewModelProtocol
}

protocol LibraryViewModelViewControllerDelegate: AnyObject {
    func libraryViewModelReloadTableView(_ libraryViewModel: LibraryViewModelProtocol, animated: Bool)
    func libraryViewModel(_ libraryViewModel: LibraryViewModelProtocol, showSpinnerView show: Bool)
    func libraryViewModelPresentFiltersView(_ libraryViewModel: LibraryViewModelProtocol)
}

enum LibraryViewSectionType {
    case courses
}

enum LibraryViewRowType: Hashable {
    case searchBar
    case filters(Set<CourseFilter>)
    case sortStyle(CourseSortStyle)
    case courseCard(CourseInfo)
}

class LibraryViewModel: LibraryViewModelProtocol {
    // MARK: - Init

    init(viewControllerDelegate: LibraryViewModelViewControllerDelegate?) {
        self.viewControllerDelegate = viewControllerDelegate
        self.fetchCourses {
            self.setupDataSource()
            self.viewControllerDelegate?.libraryViewModelReloadTableView(self, animated: false)
            self.viewControllerDelegate?.libraryViewModel(self, showSpinnerView: false)
        }
    }

    // MARK: - Private Properties

    private var courses: [CourseInfo] = []

    private var currentSearchQuery = ""

    private var activeFilters = Set<CourseFilter>()

    private var currentSortStyle = CourseSortStyle.newest

    // MARK: - Public Properties

    var title: String = "Library"

    var dataSource: [LibraryViewRowType] = []

    var numberOfSections: Int = 1

    var estimatedRowHeight: CGFloat = 205

    var githubRestService: GithubRestServiceProtocol = GithubRestService()

    weak var viewControllerDelegate: LibraryViewModelViewControllerDelegate?

    // MARK: - Public Methods

    func numberOfRowsInSection(_ section: Int) -> Int {
        dataSource.count
    }

    func getSearchBarTableViewCellViewModel() -> SearchBarTableViewCellViewModelProtocol {
        SearchBarTableViewCellViewModel(delegate: self)
    }

    func getCourseFiltersTableViewCellViewModel() -> CourseFiltersTableViewCellViewModelProtocol {
        CourseFiltersTableViewCellViewModel(
            filters: activeFilters,
            delegate: self)
    }

    func getSortStyleTableViewCellViewModel() -> SortStyleTableViewCellViewModelProtocol {
        SortStyleTableViewCellViewModel(
            title: "Tutorials",
            sortStyle: currentSortStyle,
            delegate: self)
    }

    func getLibraryViewTableViewCellViewModel(
        at indexPath: IndexPath
    ) -> LibraryViewTableViewCellViewModelProtocol? {
        guard
            case let .courseCard(courseInfo) = dataSource[indexPath.row]
        else {
            return nil
        }

        return LibraryViewTableViewCellViewModel(courseInfo: courseInfo)
    }

    func getToggleFiltersViewModel() -> ToggleFiltersViewModelProtocol {
        let technologyDomains = githubRestService.fetchedDomains

        return ToggleFiltersViewModel(
            activeFilters: activeFilters,
            technologyDomains: technologyDomains,
            delegate: self)
    }

    // MARK: - Private Methods

    private func fetchCourses(completion: @escaping () -> Void) {
        viewControllerDelegate?.libraryViewModel(self, showSpinnerView: true)
        
        githubRestService.getCourses(.article, .collection) { courses in
            self.courses = courses
            completion()
        }
    }

    private func setupDataSource() {
        var rowTypes: [LibraryViewRowType] = [.searchBar]
        if !activeFilters.isEmpty {
            rowTypes.append(.filters(activeFilters))
        }

        rowTypes.append(.sortStyle(currentSortStyle))
        
        let mappedCourses = courses
            .sorted(by: currentSortStyle)
            .filtered(by: activeFilters)
            .filterOnQuery(currentSearchQuery)
            .map { LibraryViewRowType.courseCard($0) }

        rowTypes.append(contentsOf: mappedCourses)

        self.dataSource = rowTypes
    }
}

// MARK: - SearchBarTableViewCellViewModelDelegate

extension LibraryViewModel: SearchBarTableViewCellViewModelDelegate {
    func searchBarTableViewCellViewModel(
        _ searchBarTableViewCellViewModel: SearchBarTableViewCellViewModelProtocol,
        searchQueryUpdated query: String
    ) {
        currentSearchQuery = query
        setupDataSource()
        viewControllerDelegate?.libraryViewModelReloadTableView(self, animated: true)
    }

    func searchBarTableViewCellViewModelFiltersButtonTapped(
        _ searchBarTableViewCellViewModel: SearchBarTableViewCellViewModelProtocol
    ) {
        viewControllerDelegate?.libraryViewModelPresentFiltersView(self)
    }

    private func setupDataSourceAndReloadView(
        animated: Bool = true
    ) {
        setupDataSource()
        viewControllerDelegate?.libraryViewModelReloadTableView(
            self,
            animated: animated)
    }
}

// MARK: - CourseFiltersTableViewCellViewModelDelegate

extension LibraryViewModel: CourseFiltersTableViewCellViewModelDelegate {
    func courseFiltersTableViewCellViewModel(
        _ courseFiltersTableViewCellViewModel: CourseFiltersTableViewCellViewModelProtocol,
        filterShouldBeRemoved filter: CourseFilter
    ) {
        activeFilters.remove(filter)
        setupDataSourceAndReloadView()
    }

    func courseFiltersTableViewCellViewModelRemoveAllActiveFilters(
        _ courseFiltersTableViewCellViewModel: CourseFiltersTableViewCellViewModelProtocol
    ) {
        activeFilters.removeAll()
        setupDataSourceAndReloadView()
    }
}

// MARK: - SortStyleTableViewCellViewModelDelegate

extension LibraryViewModel: SortStyleTableViewCellViewModelDelegate {
    func sortStyleTableViewCellViewModelSortStyleButtonTapped(
        _ sortStyleTableViewCellViewModel: SortStyleTableViewCellViewModelProtocol
    ) {
        currentSortStyle = currentSortStyle == .newest ? .oldest : .newest
        setupDataSourceAndReloadView(animated: false)
    }
}

// MARK: - ToggleFiltersViewModelDelegate

extension LibraryViewModel: ToggleFiltersViewModelDelegate {
    func toggleFiltersViewModel(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol,
        activeFitlersUpdated filters: Set<CourseFilter>
    ) {
        activeFilters = filters
        setupDataSourceAndReloadView()
    }
}
