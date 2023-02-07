//
//  StoreViewController.swift
//  Store
//
//  Created by Bola Fayez on 29/01/2023.
//

import UIKit

class StoreViewController: UIViewController {

    // MARK: - Cell constants
    private enum Constants {
        enum Cell {
            static let reuseIdentifier = NSStringFromClass(ProductTableViewCell.self)
        }
    }
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: Constants.Cell.reuseIdentifier)
        return tableView
    }()
    private let checkoutView = UIView()
    private let checkoutButton = UIButton()
    
    // MARK: - ViewModel
    private var viewModel: StoreViewModelProtocol
    
    // MARK: - Init
    // With viewModel
    init(viewModel: StoreViewModelProtocol = StoreViewModel()) {
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
        fetchProducts()
    }

    // MARK: - setupViews
    private func setupViews() {
        
        view.backgroundColor = .white
        title = Strings.STORE_TITLE
        
        // tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        
        // checkoutView
        checkoutView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkoutView)
        NSLayoutConstraint.activate([
            checkoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            checkoutView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            checkoutView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            checkoutView.heightAnchor.constraint(equalToConstant: 56)
        ])
        checkoutView.isHidden = true
        
        // checkoutButton
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutView.addSubview(checkoutButton)
        NSLayoutConstraint.activate([
            checkoutButton.topAnchor.constraint(equalTo: checkoutView.topAnchor, constant: 8),
            checkoutButton.bottomAnchor.constraint(equalTo: checkoutView.bottomAnchor, constant: -8),
            checkoutButton.leadingAnchor.constraint(equalTo: checkoutView.leadingAnchor, constant: 8),
            checkoutButton.trailingAnchor.constraint(equalTo: checkoutView.trailingAnchor, constant: -8)
        ])
        checkoutButton.setTitle(Strings.CHECKOUT_TITLE, for: .normal)
        checkoutButton.backgroundColor = .black
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 4
        checkoutButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        checkoutButton.addTarget(self, action: #selector(moveToCheckout), for: .touchUpInside)

        // isCheckout
        viewModel.onCheckoutStart = { [weak self] available in
            self?.onCheckoutStart(isCheckout: available)
        }
        
    }
    
    // MARK: - onCheckoutStart
    private func onCheckoutStart(isCheckout: Bool) {
        checkoutView.isHidden = !isCheckout
    }
    
    // MARK: - moveToCheckout
    @objc func moveToCheckout(sender: UIButton) {
        let viewController = CheckoutViewController(viewModel: CheckoutViewModel(items: viewModel.startCheckOutWithItems()))
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - Fetch Products
extension StoreViewController {
    
    private func fetchProducts() {
        viewModel.fetchProducts(completion: { [weak self] result in
            switch result {
            case .success:
                self?.handleFetchSuccess()
            case .failure(let error):
                self?.handleFailure(error: error.getStringError() ?? "")
            }
        })
    }
    
    private func handleFetchSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func handleFailure(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorAlert(message: error)
        }
    }
    
}

// MARK: - AddToCart action
extension StoreViewController {
    
    // MARK: - handleAction
    private func handleAction(_ action: AddToCartAction) {
        switch action {
        case .addToCart(let product, let quantity):
            viewModel.addToCart(product: product, quantity: quantity)
        }
    }
    
}

// MARK: - TableView Data Source
extension StoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.reuseIdentifier, for: indexPath)

        let layoutViewModel = viewModel.productAt(index: indexPath.row)
        
        guard let layoutViewModel = layoutViewModel else {
            return cell
        }
        
        if let cell = cell as? ProductTableViewCell {
            cell.loadViewWithLayoutViewModel(product: layoutViewModel, onAction: self.handleAction(_:))
        }
        
        return cell
    }
}
