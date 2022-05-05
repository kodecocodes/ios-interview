import Foundation

protocol FilterSubtypeTableViewCellViewModelProtocol {
    var title: String? { get }
    var isSelected: Bool { get set }
    var delegate: FilterSubtypeTableViewCellViewModelDelegate? { get set }

    func radioButtonTapped()
}

protocol FilterSubtypeTableViewCellViewModelDelegate: AnyObject {
    func filterSubtypeTableViewCellViewModelRadioButtonTapped(
        _ filterSubtypeTableViewCellViewModel: FilterSubtypeTableViewCellViewModelProtocol,
        subtype: CourseFilter
    )
}

class FilterSubtypeTableViewCellViewModel: FilterSubtypeTableViewCellViewModelProtocol {
    // MARK: - Init
    
    init(
        subtype: CourseFilter,
        isSelected: Bool,
        delegate: FilterSubtypeTableViewCellViewModelDelegate? = nil
    ) {
        self.subtype = subtype
        self.isSelected = isSelected
        self.delegate = delegate
    }

    // MARK: - Private Properties

    private var subtype: CourseFilter

    // MARK: - Public Properties
    
    var title: String? {
        subtype.subtypeName
    }

    var isSelected: Bool

    weak var delegate: FilterSubtypeTableViewCellViewModelDelegate?

    // MARK: - Public Methods

    func radioButtonTapped() {
        delegate?.filterSubtypeTableViewCellViewModelRadioButtonTapped(
            self,
            subtype: subtype)
    }
}
