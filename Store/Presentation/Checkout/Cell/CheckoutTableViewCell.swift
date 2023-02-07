//
//  CheckoutTableViewCell.swift
//  Store
//
//  Created by Bola Fayez on 07/02/2023.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

    // MARK: - UI
    private let containerView = UIView()
    private let nameLbl = UILabel()
    private let quantityLbl = UILabel()
    
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
        
        // nameLbl
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            nameLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        nameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        nameLbl.textColor = .darkGray
        
        // quantityLbl
        quantityLbl.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(quantityLbl)
        NSLayoutConstraint.activate([
            quantityLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            quantityLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            quantityLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        quantityLbl.font = UIFont.boldSystemFont(ofSize: 12)
        quantityLbl.textColor = .lightGray
    }

}

// MARK: - loadViewWithLayoutViewModel
extension CheckoutTableViewCell {
    
    func loadViewWithLayoutViewModel(product: CheckoutLayoutViewModel) {
        
        self.nameLbl.text = product.name
        self.quantityLbl.text = "x\(product.quantity)"
    }
    
}
