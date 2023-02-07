//
//  CheckoutViewController.swift
//  Store
//
//  Created by Bola Fayez on 06/02/2023.
//

import UIKit

class CheckoutViewController: UIViewController {

    // MARK: - Cell constants
    private enum Constants {
        enum Cell {
            static let reuseIdentifier = NSStringFromClass(CheckoutTableViewCell.self)
        }
    }
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CheckoutTableViewCell.self, forCellReuseIdentifier: Constants.Cell.reuseIdentifier)
        return tableView
    }()
    private let totalLabel = UILabel()
    
    // MARK: - ViewModel
    private var viewModel: CheckoutViewModelProtocol
    
    // MARK: - Init
    // With viewModel
    init(viewModel: CheckoutViewModelProtocol = CheckoutViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = Strings.CHECKOUT_TITLE
        
        // totalLabel
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalLabel)
        totalLabel.textColor = .black
        totalLabel.font = .boldSystemFont(ofSize: 18)
        totalLabel.numberOfLines = 0
        totalLabel.text = "TOTAL: \(viewModel.price)$"
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            totalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            totalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16)
        ])
        
        // tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.reloadData()
    }

}

// MARK: - TableView Data Source
extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.reuseIdentifier, for: indexPath)

        let layoutViewModel = viewModel.productAt(index: indexPath.row)
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? CheckoutTableViewCell {
            cell.loadViewWithLayoutViewModel(product: layoutViewModel)
        }
        
        return cell
    }
}

