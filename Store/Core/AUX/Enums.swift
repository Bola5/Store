//
//  Enums.swift
//  Store
//
//  Created by Bola Fayez on 07/02/2023.
//

import Foundation

// MARK: - AddToCartAction
enum AddToCartAction {
    case addToCart(product: StoreLayoutViewModel.ProductLayoutViewModel, quantity: Int)
}

enum ItemEnum: String {
    case vocuher = "VOUCHER"
    case tshirt = "TSHIRT"
    case mug = "MUG"
}
