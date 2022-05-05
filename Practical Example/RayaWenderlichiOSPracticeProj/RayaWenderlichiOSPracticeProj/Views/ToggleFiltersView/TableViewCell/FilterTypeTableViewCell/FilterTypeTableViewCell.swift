import UIKit

class FilterTypeTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var expandArrowImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Public Properties

    var viewModel: FilterTypeTableViewCellViewModelProtocol? {
        didSet {
            setup()
        }
    }

    // MARK: - Setup Methods

    private func setup() {
        stylizeView()
        setupSubviews()
        tableView.reloadData()
    }

    private func stylizeView() {
        cellBackgroundView.backgroundColor = .backgroundSecondaryDark
        cellBackgroundView.layer.cornerRadius = 10
    }

    private func setupSubviews() {
        setupLabels()
        setupExpandArrowImageView()
        setupTableView()
    }

    private func setupLabels() {
        titleLabel.text = viewModel?.title
        titleLabel.textColor = .textOffWhite
        
        subtitleLabel.text = viewModel?.subtitle
        subtitleLabel.textColor = .textBlueGray
    }

    private func setupExpandArrowImageView() {
        expandArrowImageView.image = viewModel?.collapseArrowImage
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = viewModel?.rowHeight ?? 0
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false

        tableView.registerCell(ofType: FilterSubtypeTableViewCell.self)
    }

    // MARK: - Callbacks
    
    @IBAction func cellBackgroundViewButtonTapped(_ sender: Any) {
        viewModel?.cellBackgroundViewButtonTapped()
        UIImpactFeedbackGenerator.generate(style: .light)
    }
}

// MARK: - UITableViewDataSource

extension FilterTypeTableViewCell: UITableViewDataSource, UITableViewDelegate {
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
        let cell: FilterSubtypeTableViewCell = tableView.dequeueTypedCell(at: indexPath)
        cell.viewModel = viewModel?.getFilterSubtypeTableViewCellViewModel(at: indexPath)

        return cell
    }
}
