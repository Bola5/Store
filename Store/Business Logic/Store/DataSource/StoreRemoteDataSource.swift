//
//  StoreRemoteDataSource.swift
//  Store
//
//  Created by Bola Fayez on 05/02/2023.
//

import Foundation

protocol StoreRemoteDataSourceProtocal {
    func fetchProducts(completion: @escaping (Result<StoreModel, ErrorManager>) -> Void)
}

class StoreRemoteDataSource: StoreRemoteDataSourceProtocal {
    
    private let communicationManagerProtocol: CommunicationManagerProtocol
    
    init(communicationManagerProtocol: CommunicationManagerProtocol = CommunicationManager()) {
        self.communicationManagerProtocol = communicationManagerProtocol
    }

    func fetchProducts(completion: @escaping (Result<StoreModel, ErrorManager>) -> Void) {
        communicationManagerProtocol.request(urlString: EndPoints.fetchProducts.asRequest(), completion: { (result : Result<StoreModel, ErrorManager>) in
            switch result {
                case .success(let model):
                completion(.success(model))
                case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
