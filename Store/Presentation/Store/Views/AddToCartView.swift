//
//  AddToCartView.swift
//  Store
//
//  Created by Bola Fayez on 06/02/2023.
//

import UIKit

class AddToCartView: UIView {
    
    // MARK: - UI
    private let addToCartButton = UIButton()
    private let changeQuantityView = ChangeQuantityView()
    
    // MARK: - Properties
    var onActionEvent: ((Int) -> Void)?
    
    // MARK: - Init
    // Cell style
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    // MARK: - With a coder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    private func setupViews() {

        // addToCartButton
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addToCartButton)
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: topAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        addToCartButton.setTitle(Strings.ADD_TO_CART_TITLE, for: .normal)
        addToCartButton.layer.cornerRadius = 4
        addToCartButton.backgroundColor = UIColor.gray
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = .systemFont(ofSize: 14)
        addToCartButton.addTarget(self, action: #selector(AddToCartAction), for: .touchUpInside)
    }
    
    // MARK: - showChangeQuantityView
    private func showChangeQuantityView() {
        addToCartButton.isHidden = true
        changeQuantityView.isHidden = false
        
        changeQuantityView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(changeQuantityView)
        NSLayoutConstraint.activate([
            changeQuantityView.topAnchor.constraint(equalTo: topAnchor),
            changeQuantityView.leadingAnchor.constraint(equalTo: leadingAnchor),
            changeQuantityView.trailingAnchor.constraint(equalTo: trailingAnchor),
            changeQuantityView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        changeQuantityView.onActionEvent = { [weak self] quantity in
            self?.setupQuantity(quantity: quantity)
        }
    }
    
    // MARK: - setupQuantity
    private func setupQuantity(quantity: Int) {
        addToCartButton.isHidden = quantity < 1 ? false : true
        changeQuantityView.isHidden = quantity < 1 ? true : false
        onActionEvent?(quantity)
    }
    
    // MARK: - Actions
    @objc func AddToCartAction(sender: UIButton) {
        showChangeQuantityView()
        onActionEvent?(1)
    }

}
