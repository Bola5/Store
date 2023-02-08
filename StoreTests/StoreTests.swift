//
//  StoreTests.swift
//  StoreTests
//
//  Created by Bola Fayez on 08/02/2023.
//

import XCTest
@testable import Store

final class StoreTests: XCTestCase {

    // MARK: - Properties
    private var viewModel: StoreViewModel!
    private var dataSource: StoreRemoteDataSource!

    // MARK: - tearDown
    override func tearDown() {
        
        viewModel = nil
        dataSource = nil
        
        super.tearDown()
    }
    
    // MARK: - testRetrivedRemoteDataProducts
    func testRetrivedRemoteDataProducts() {
        
        let mockData = StoreModel.parse(jsonFile: "products")
        let getStoreAPI = StoreAPITests(data: mockData)
        dataSource = StoreRemoteDataSource(communicationManagerProtocol: getStoreAPI)
        
        dataSource.fetchProducts(completion: { result in
            switch result {
            case .success(let storeModel):
                XCTAssertNotNil(storeModel.products)
                XCTAssertTrue(storeModel.products.count > 0)
            case .failure(let error):
                XCTAssertNotNil(error.getStringError())
            }
        })
        
    }
    
    // MARK: - testFetchProducts
    func testFetchProducts() {
                
        viewModel = StoreViewModel(storeRemoteDataSource: MockRemoteDataSourceGetStoreProducts())
        
        viewModel.fetchProducts(completion: { [weak self] result in
            switch result {
                
            case .success:
                
                XCTAssertEqual(self?.viewModel.countOfProducts, 3)
                
                if let firstProduct = self?.viewModel.productAt(index: 0) {
                    XCTAssertEqual(firstProduct.name, "Cabify Voucher")
                    XCTAssertEqual(firstProduct.code, "VOUCHER")
                    XCTAssertEqual(firstProduct.price, 5)
                } else {
                    XCTFail("This should not happen.")
                }
                
                if let lastProduct = self?.viewModel.productAt(index: 2) {
                    XCTAssertEqual(lastProduct.name, "Cabify Coffee Mug")
                    XCTAssertEqual(lastProduct.code, "MUG")
                    XCTAssertEqual(lastProduct.price, 7.5)
                } else {
                    XCTFail("This should not happen.")
                }
                
            case .failure:
                XCTFail("This should not happen.")
            }
        })
        
    }
    
}

// MARK: - Mocks
extension StoreTests {
    
    // MARK: - MockRemoteDataSourceGetStoreProducts
    struct MockRemoteDataSourceGetStoreProducts: StoreRemoteDataSourceProtocal {
        
        private let storeModel = StoreModel(products: [StoreModel.Products(code: "VOUCHER", name: "Cabify Voucher", price: 5),
                                                       StoreModel.Products(code: "TSHIRT", name: "Cabify T-Shirt", price: 20),
                                                       StoreModel.Products(code: "MUG", name: "Cabify Coffee Mug", price: 7.5)])
        
                
        func fetchProducts(completion: @escaping (Result<Store.StoreModel, Store.ErrorManager>) -> Void) {
            completion(.success(storeModel))
        }
        
    }
    
}
