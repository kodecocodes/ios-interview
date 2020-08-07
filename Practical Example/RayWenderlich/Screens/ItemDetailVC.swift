//
//  ItemDetailViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    var item: Item!
    
    var playerView = UIView()
    var courseInfoView = UIView()
    
    init(with item: Item) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCourseInfoVC(with: item)
        configurePlayerVC()
        layoutUI()
        addToInProgress()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
    }
    
    func layoutUI() {
        view.addSubviews(playerView, courseInfoView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        courseInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),
            
            courseInfoView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            courseInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            courseInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            courseInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configurePlayerVC() {
        self.add(childVC: PlayerVC(with: item), to: self.playerView)
    }
    
    func configureCourseInfoVC(with item: Item) {
        self.add(childVC: CourseInfoVC(with: item), to: self.courseInfoView)
    }
    
    func addToInProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            PersistenceManager.updateItems(for: Keys.inProgress, with: self.item, actionType: .add) { [weak self] error in
                guard let self = self else { return }
                
                guard let error = error else {
                    DispatchQueue.main.async { UIHelper.createAlertController(title: "Added!", message: "Successfully added to in progress!", in: self) }
                    return
                }
                
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
            }
        }
    }
}
