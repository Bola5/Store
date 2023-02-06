//
//  StoreLayoutViewModel.swift
//  Store
//
//  Created by Bola Fayez on 05/02/2023.
//

import Foundation

struct StoreLayoutViewModel {

    let products: [ProductLayoutViewModel]
    
    init(store: StoreModel) {
        self.products = store.products.compactMap({ ProductLayoutViewModel(product: $0) })
    }
    
    struct ProductLayoutViewModel {
        
        let code: String
        let name: String
        let price: Int
        
        init(product: StoreModel.Products) {
            self.code = product.code
            self.name = product.name
            self.price = product.price
        }
        
    }

}
