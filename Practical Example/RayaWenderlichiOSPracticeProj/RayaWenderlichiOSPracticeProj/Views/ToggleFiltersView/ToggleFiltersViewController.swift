import UIKit

class ToggleFiltersViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Public Properties
    
    var viewModel: ToggleFiltersViewModelProtocol?

    // MARK: - Setup Methods
    
    private func setup() {
        viewModel?.viewControllerDelegate = self
        view.backgroundColor = .backgroundPrimaryDark
        setupTitleLabel()
        setupTableView()
        setupButtons()
    }

    private func setupTitleLabel() {
        titleLabel.text = viewModel?.title
        titleLabel.textColor = .textOffWhite
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false

        tableView.registerCell(ofType: FilterTypeTableViewCell.self)
    }

    private func setupButtons() {
        setupClearAllButton()
        setupApplyButton()
    }

    private func setupClearAllButton() {
        clearAllButton.layer.cornerRadius = 10
        clearAllButton.backgroundColor = .backgroundSecondaryDark
    }

    private func setupApplyButton() {
        applyButton.layer.cornerRadius = 10
        applyButton.backgroundColor = .wenderlichOffGreen
    }

    // MARK: - Callbacks

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func clearAllButtonTapped(_ sender: Any) {
        viewModel?.clearAllButtonTapped()
    }

    @IBAction func applyButtonTapped(_ sender: Any) {
        viewModel?.applyButtonTapped()
    }
}

// MARK: - UITableViewDataSource

extension ToggleFiltersViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: FilterTypeTableViewCell = tableView.dequeueTypedCell(at: indexPath)
        cell.viewModel = viewModel?.getFilterTypeTableViewCellViewModel(at: indexPath)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ToggleFiltersViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        viewModel?.heightForRow(at: indexPath) ?? 0
    }
}

// MARK: - ToggleFiltersViewModelViewControllerDelegate

extension ToggleFiltersViewController: ToggleFiltersViewModelViewControllerDelegate {
    func toggleFiltersViewModelReloadTableView(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol
    ) {
        tableView.reloadData()
    }

    func toggleFiltersViewModelUpdateTableView(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol,
        completion: @escaping () -> Void
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock { completion() }

        tableView.beginUpdates()
        tableView.endUpdates()

        CATransaction.commit()
    }

    func toggleFiltersViewModelDismissSelf(
        _ toggleFiltersViewModel: ToggleFiltersViewModelProtocol
    ) {
        dismiss(animated: true, completion: nil)
    }
}
