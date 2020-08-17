//
//  ItemDetailViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    var item: Item!
    
    var playerView = UIView()
    var scrollView = UIScrollView()
    var contentView = UIView()
    var courseInfoView = UIView()
  var emptyStateView = RWEmptyStateView(frame: .zero)
    
    init(with item: Item) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      if !item.id.isEmpty {
        configureViewController()
        configureCourseInfoVC(with: item)
        configurePlayerVC()
        configureScrollView()
      } else {
        configureViewController()
        view.addSubview(emptyStateView)
        emptyStateView.pinToEdges(of: view)
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .secondarySystemBackground
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 650)
        ])
        
        layoutUI(in: contentView)
    }
    
    func layoutUI(in view: UIView) {
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
}
