import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate {
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private Properties

    private lazy var diffableDataSource = createDiffableDataSource()

    private var spinnerView: SpinnerViewController = {
        SpinnerViewController()
    }()

    // MARK: - Public properties
    
    var viewModel: LibraryViewModelProtocol?

    // MARK: - Setup Methods

    private func setup() {
        viewModel = LibraryViewModel(viewControllerDelegate: self)
        diffableDataSource.defaultRowAnimation = .fade
        view.backgroundColor = .backgroundPrimaryDark
        setupNavigationElements()
        setupTableView()
        updateDiffableDataSourceTableView(animate: false)
    }

    private func setupNavigationElements() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .backgroundPrimaryDark
        navigationItem.title = viewModel?.title

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textOffWhite]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    private func setupTableView() {
        tableView.dataSource = diffableDataSource
        tableView.delegate = self
        tableView.estimatedRowHeight = viewModel?.estimatedRowHeight ?? 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.registerCell(ofType: SearchBarTableViewCell.self)
        tableView.registerCell(ofType: CourseFiltersTableViewCell.self)
        tableView.registerCell(ofType: SortStyleTableViewCell.self)
        tableView.registerCell(ofType: LibraryViewTableViewCell.self)
    }

    // MARK: - Private methods

    private func showSpinnerView() {
        addChild(spinnerView)
        spinnerView.view.frame = view.frame
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
    }

    private func hideSpinnerView() {
        spinnerView.willMove(toParent: nil)
        spinnerView.view.removeFromSuperview()
        spinnerView.removeFromParent()
    }

    private func presentToggleFiltersView() {
        guard
            let vc: ToggleFiltersViewController = UIStoryboard.instantiateTypedVC()
        else {
            return
        }
        
        vc.viewModel = viewModel?.getToggleFiltersViewModel()
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - CustomUITableViewDiffableDataSource

extension LibraryViewController {
    private func createDiffableDataSource() -> UITableViewDiffableDataSource<LibraryViewSectionType, LibraryViewRowType> {
        let dataSource: UITableViewDiffableDataSource<LibraryViewSectionType, LibraryViewRowType> = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, _ in
            guard let dataSource = self.viewModel?.dataSource else {
                return UITableViewCell()
            }

            switch dataSource[indexPath.row] {
            case .searchBar:
                let cell: SearchBarTableViewCell = tableView.dequeueTypedCell(at: indexPath)
                cell.viewModel = self.viewModel?.getSearchBarTableViewCellViewModel()

                return cell
            case .filters:
                let cell: CourseFiltersTableViewCell = tableView.dequeueTypedCell(at: indexPath)
                cell.viewModel = self.viewModel?.getCourseFiltersTableViewCellViewModel()

                return cell
            case .sortStyle:
                let cell: SortStyleTableViewCell = tableView.dequeueTypedCell(at: indexPath)
                cell.viewModel = self.viewModel?.getSortStyleTableViewCellViewModel()
                
                return cell
            case .courseCard:
                let cell: LibraryViewTableViewCell = tableView.dequeueTypedCell(at: indexPath)
                cell.viewModel = self.viewModel?.getLibraryViewTableViewCellViewModel(at: indexPath)

                return cell
            }
        }

        return dataSource
    }

    private func updateDiffableDataSourceTableView(animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<LibraryViewSectionType, LibraryViewRowType>()
        snapshot.appendSections([LibraryViewSectionType.courses])
        snapshot.appendItems(viewModel?.dataSource ?? [], toSection: .courses)

        diffableDataSource.apply(snapshot, animatingDifferences: animate)
    }
}

// MARK: - LibraryViewModelViewControllerDelegate

extension LibraryViewController: LibraryViewModelViewControllerDelegate {
    func libraryViewModelReloadTableView(
        _ libraryViewModel: LibraryViewModelProtocol,
        animated: Bool
    ) {
        DispatchQueue.main.async {
            self.updateDiffableDataSourceTableView(animate: animated)
        }
    }

    func libraryViewModel(
        _ libraryViewModel: LibraryViewModelProtocol,
        showSpinnerView show: Bool
    ) {
        show ? showSpinnerView() : hideSpinnerView()
    }

    func libraryViewModelPresentFiltersView(
        _ libraryViewModel: LibraryViewModelProtocol
    ) {
        presentToggleFiltersView()
    }
}
