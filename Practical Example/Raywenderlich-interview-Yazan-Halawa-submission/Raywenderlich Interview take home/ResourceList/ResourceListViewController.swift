//
//  ViewController.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/13/22.
//

import UIKit
import Combine
import OSLog

class ResourceListViewController: UIViewController, UITableViewDelegate {
    let tableView = UITableView()
    let stackView = UIStackView()
    let buttonsStackView = UIStackView()
    let loadingIndicator = UIActivityIndicatorView()
    let viewModel = ResourceListViewModel()
    
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
        buttonsStackView.axis = .horizontal
        pinStackViewToParentView()

        let articlesButton = UIButton(configuration: .bordered())
        articlesButton.setTitle("Articles", for: .normal)
        articlesButton.addTarget(self.viewModel, action: #selector(viewModel.showOnlyArticles), for: .touchUpInside)
        let videosButton = UIButton(configuration: .bordered())
        videosButton.setTitle("Videos", for: .normal)
        videosButton.addTarget(self.viewModel, action: #selector(viewModel.showOnlyVideos), for: .touchUpInside)
        let allButton = UIButton(configuration: .bordered())
        allButton.setTitle("Both", for: .normal)
        allButton.addTarget(self.viewModel, action: #selector(viewModel.showAllTypes), for: .touchUpInside)
        
        buttonsStackView.addArrangedSubview(articlesButton)
        buttonsStackView.addArrangedSubview(videosButton)
        buttonsStackView.addArrangedSubview(allButton)
                    
        stackView.addArrangedSubview(buttonsStackView)
        setupTableView()
        startInLoadingState()
        fetchData()
    }
    
    private func pinStackViewToParentView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        tableView.register(ResourceView.nib, forCellReuseIdentifier: ResourceView.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        stackView.addArrangedSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func startInLoadingState() {
        tableView.isHidden = true
        view.addSubview(loadingIndicator)
        loadingIndicator.isHidden = false
        loadingIndicator.color = .black
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        loadingIndicator.center = self.view.center
    }
    
    private func fetchData() {
        subscriptions = [
            viewModel.$resources
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    self.loadingIndicator.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                })
        ]
        Task {
            await viewModel.fetchResources()
        }
    }
}

extension ResourceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResourceView.identifier, for: indexPath) as? ResourceView else {
            Logger.viewCycle.error("Failed to dequeue reusable cell with identifier (Resource) at indexPath \(indexPath.row),\(indexPath.section)")
            return UITableViewCell()
        }
        if indexPath.row >= 0 && indexPath.row < viewModel.resources.count {
            let resource = viewModel.resources[indexPath.row]
            cell.nameLabel.text = resource.attributes.name
            cell.descriptionLabel.text = resource.attributes.description
            // Start image with loading
            cell.artworkImageView.image = UIImage(named: "placeholder")
            cell.artworkImageView.load(fromURL: resource.attributes.card_artwork_url)
            cell.typeLabel.text = resource.attributes.content_type.rawValue
        }
        return cell
    }
}
