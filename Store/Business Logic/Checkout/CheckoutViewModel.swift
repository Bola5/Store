//
//  CheckoutViewModel.swift
//  Store
//
//  Created by Bola Fayez on 07/02/2023.
//

import Foundation

protocol CheckoutViewModelProtocol {
    
    //MARK: - Protocol - Data Source
    var price: String { get }
    var countOfProducts: Int { get }
    func productAt(index: Int) -> CheckoutLayoutViewModel?
}

class CheckoutViewModel: CheckoutViewModelProtocol {

    // MARK: - Properties
    private var items = [StoreLayoutViewModel.CartLayoutViewModel]()
    private var totalItems: String = ""
    private var total: Float = 0
    var price: String {
        return String(total)
    }
    private var layoutViewModel = [CheckoutLayoutViewModel]()
    var countOfProducts: Int {
        return layoutViewModel.count
    }
    
    // MARK: - Init
    init(items: [StoreLayoutViewModel.CartLayoutViewModel] = [StoreLayoutViewModel.CartLayoutViewModel]()) {
        
        self.items = items
        
        getReceipt()
    }
    
}

// MARK: - Protocol - Data Source method
extension CheckoutViewModel {
    
    // Product at index
    func productAt(index: Int) -> CheckoutLayoutViewModel? {
        return self.layoutViewModel[index]
    }
}

// MARK: - getReceipt
extension CheckoutViewModel {
    
    private func getReceipt() {
        for item in items {
            switch item.product.code {
            case ItemEnum.vocuher.rawValue:
                if item.quantity % 2 == 0 {
                    total += ((item.product.price)*Float((item.quantity) / 2))
                } else {
                    total += ((item.product.price)*Float((item.quantity - 1) / 2))
                    total += (item.product.price)
                }
                layoutViewModel.append(CheckoutLayoutViewModel(name: ItemEnum.vocuher.rawValue, quantity: "\(item.quantity)"))
            case ItemEnum.tshirt.rawValue:
                total +=  item.quantity >= 3 ? ((item.product.price - 1)*Float(item.quantity)) : ((item.product.price)*Float(item.quantity))
                layoutViewModel.append(CheckoutLayoutViewModel(name: ItemEnum.tshirt.rawValue, quantity: "\(item.quantity)"))
            case ItemEnum.mug.rawValue:
                total += ((item.product.price)*Float(item.quantity))
                layoutViewModel.append(CheckoutLayoutViewModel(name: ItemEnum.mug.rawValue, quantity: "\(item.quantity)"))
            default: break
            }
        }
    }
    
}
