//
//  StoreViewModel.swift
//  Store
//
//  Created by Bola Fayez on 05/02/2023.
//

import Foundation

protocol StoreViewModelProtocol {
    
    //MARK: - Protocol - Data Source
    var countOfProducts: Int { get }
    var isCheckoutEnable: Bool? { get }
    var onCheckoutStart: ((Bool) -> Void)? { get set }
    func productAt(index: Int) -> StoreLayoutViewModel.ProductLayoutViewModel?
    func addToCart(product: StoreLayoutViewModel.ProductLayoutViewModel, quantity: Int)
    func startCheckOutWithItems() -> [StoreLayoutViewModel.CartLayoutViewModel]
    
    // MARK: - Protocol - fetch
    func fetchProducts(completion: @escaping StoreViewModel.GetProductsCompletionBlock)
}

class StoreViewModel: StoreViewModelProtocol {

    // MARK: - Callback type alias
    typealias GetProductsCompletionBlock = (Result<Bool, ErrorManager>) -> Void

    // MARK: - Properties
    // Data Source
    private let storeRemoteDataSource: StoreRemoteDataSourceProtocal
    private var layoutViewModel: StoreLayoutViewModel?
    private var cartLayoutViewModel = [StoreLayoutViewModel.CartLayoutViewModel]()
    var countOfProducts: Int {
        return layoutViewModel?.products.count ?? 0
    }
    var isCheckoutEnable: Bool? {
        didSet {
            onCheckoutStart?(isCheckoutEnable ?? false)
        }
    }
    var onCheckoutStart: ((Bool) -> Void)?
    
    // Init
    init(storeRemoteDataSource: StoreRemoteDataSourceProtocal = StoreRemoteDataSource()) {
        
        self.storeRemoteDataSource = storeRemoteDataSource
    }
    
}

// MARK: - Protocol - Data Source method
extension StoreViewModel {
    
    // Product at index
    func productAt(index: Int) -> StoreLayoutViewModel.ProductLayoutViewModel? {
        return self.layoutViewModel?.products[index]
    }
    
    // AddToCart
    func addToCart(product: StoreLayoutViewModel.ProductLayoutViewModel, quantity: Int) {
        if let index = cartLayoutViewModel.firstIndex(where: { $0.product.code == product.code }) {
            cartLayoutViewModel.remove(at: index)
        }
        if quantity != 0 {
            cartLayoutViewModel.append(StoreLayoutViewModel.CartLayoutViewModel(product: product, quantity: quantity))
        }
        isCheckoutEnable = cartLayoutViewModel.isEmpty ? false : true
    }
    
    // startCheckOutWithItems
    func startCheckOutWithItems() -> [StoreLayoutViewModel.CartLayoutViewModel] {
        return cartLayoutViewModel
    }

}

// MARK: - Protocol - fetch
extension StoreViewModel {
    
    func fetchProducts(completion: @escaping GetProductsCompletionBlock) {
        storeRemoteDataSource.fetchProducts(completion: { [weak self] (result: Result<StoreModel, ErrorManager>) in
            switch result {
            case .success(let storeModel):
                self?.layoutViewModel = StoreLayoutViewModel(store: storeModel)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(.parser(string: error.localizedDescription)))
            }
        })
        
    }
    
}
