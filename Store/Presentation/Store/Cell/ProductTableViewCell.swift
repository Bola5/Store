//
//  ProductTableViewCell.swift
//  Store
//
//  Created by Bola Fayez on 06/02/2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    // MARK: - UI
    private let containerView = UIView()
    private let productImageView = UIImageView()
    private let nameLbl = UILabel()
    private let priceLbl = UILabel()
    private let cartView = AddToCartView()
    
    // MARK: - Init
    // Cell style
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    // MARK: - With a coder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    private func setupViews() {
        
        selectionStyle = .none
        
        // containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // productImageView
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            productImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        productImageView.image = UIImage(named: Strings.PLACEHOLDER_IMAGE)
        
        // nameLbl
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLbl.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            nameLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        nameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        nameLbl.textColor = .black
        
        // priceLbl
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(priceLbl)
        NSLayoutConstraint.activate([
            priceLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 8),
            priceLbl.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        priceLbl.font = UIFont.boldSystemFont(ofSize: 12)
        priceLbl.textColor = .black
        
        // cartView
        cartView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cartView)
        NSLayoutConstraint.activate([
            cartView.topAnchor.constraint(equalTo: priceLbl.bottomAnchor, constant: 8),
            cartView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            cartView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            cartView.widthAnchor.constraint(equalToConstant: 100),
            cartView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }

}

// MARK: - loadViewWithLayoutViewModel
extension ProductTableViewCell {
    
    func loadViewWithLayoutViewModel(product: StoreLayoutViewModel.ProductLayoutViewModel?, onAction: ((AddToCartAction) -> Void)?) {
        guard let product = product else { return }
        
        self.nameLbl.text = product.name
        self.priceLbl.text = "\(product.price)$"
        
        self.cartView.onActionEvent = { quantity in
            onAction?(.addToCart(product: product, quantity: quantity))
        }
    }
    
}

