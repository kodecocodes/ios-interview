import UIKit

class CourseFiltersTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupCollectionView()
    }

    // MARK: - Public Properties

    var viewModel: CourseFiltersTableViewCellViewModelProtocol? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Setup Methods

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        setupCollectionViewLayout()

        collectionView.registerCell(ofType: FilterOptionCollectionViewCell.self)
    }

    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal

        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionViewDataSource

extension CourseFiltersTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: FilterOptionCollectionViewCell = collectionView.dequeueTypedCell(at: indexPath)
        cell.viewModel = viewModel?.getFilterOptionCollectionViewCellViewModel(at: indexPath)

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel?.itemSelected(at: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CourseFiltersTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = viewModel?.getItemWidth(at: indexPath) ?? 125
        return CGSize(width: width, height: 44)
    }
}
