//
//  StoreModel.swift
//  Store
//
//  Created by Bola Fayez on 05/02/2023.
//

import Foundation

struct StoreModel: Codable {
    
    let products: [Products]
    
    struct Products: Codable {
        let code: String
        let name: String
        let price: Float
    }
    
}
