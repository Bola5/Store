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
    var countOfProducts: Int {
        return layoutViewModel?.products.count ?? 0
    }
    
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
