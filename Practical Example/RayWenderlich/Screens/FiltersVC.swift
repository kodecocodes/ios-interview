//
//  FiltersVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

protocol FiltersVCDelegate: class {
    func updateUI(with filter: String)
}

class FiltersVC: UIViewController {
    
    weak var delegate: FiltersVCDelegate!
    
    var contentType: [ContentType] = []
    var selectedRow: SelectedRow!
    
    var tableView: UITableView!
    
    var clearButton = RWButton(title: "Clear All", backgroundImage: nil, backgroundColor: .darkGray, tintColor: .white)
    var applyButton = RWButton(title: "Apply", backgroundImage: nil, backgroundColor: UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1), tintColor: .white)
    
    var areSelected: [Bool] = [false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentType.append(ContentType(type: "Article", isSelected: false))
        contentType.append(ContentType(type: "Collection", isSelected: false))
        contentType.append(ContentType(type: "All", isSelected: true))

        configureViewController()
        configureTableView()
        layoutUI()
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.tintColor = .secondaryLabel
        
        let closeButton = UIBarButtonItem(image: Images.close, style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        view.addSubview(tableView)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        ])
    }
    
    func layoutUI() {
        view.addSubviews(
            clearButton,
            applyButton
        )
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -(padding * 3 / 2)),
            clearButton.heightAnchor.constraint(equalToConstant: 50),
            
            applyButton.bottomAnchor.constraint(equalTo: clearButton.bottomAnchor),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            applyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -(padding * 3 / 2)),
            applyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func clearButtonTapped() {
        delegate.updateUI(with: "All")
        dismiss(animated: true)
    }
    
    @objc func applyButtonTapped() {
        delegate.updateUI(with: selectedRow.type.type)
        dismiss(animated: true)
    }
    
    func indexPathIsSelected(_ indexPath: IndexPath) -> Bool {
        let selectedIndexPath = selectedRow.indexPath
        
        if selectedIndexPath.row == indexPath.row {
            return true
        }
        
        return false
    }
    
    func updateIndexPathSelected(for type: ContentType, _ indexPath: IndexPath) {
        selectedRow = SelectedRow(type: type, indexPath: indexPath)
    }
}

extension FiltersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        updateIndexPathSelected(for: contentType[indexPath.row], indexPath)
    }
}

extension FiltersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let type = contentType[indexPath.row]
        
        if type.isSelected { selectedRow = SelectedRow(type: type, indexPath: indexPath) }
        
        cell.textLabel?.text = type.type
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Content Type"
    }
}
