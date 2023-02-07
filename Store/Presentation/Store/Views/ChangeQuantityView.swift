//
//  ChangeQuantityView.swift
//  Store
//
//  Created by Bola Fayez on 06/02/2023.
//

import UIKit

class ChangeQuantityView: UIView {

    // MARK: - UI
    private let stackView = UIStackView()
    private let increaseButton = UIButton()
    private let decreaseButton = UIButton()
    private let quantityLabel = UILabel()
    
    // MARK: - Properties
    private var quantity: Int = 1
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
        
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing

        // increaseButton
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(increaseButton)
        increaseButton.setTitle(Strings.INCREASE_TITLE, for: .normal)
        increaseButton.layer.cornerRadius = 4
        increaseButton.backgroundColor = UIColor.gray
        increaseButton.setTitleColor(.white, for: .normal)
        increaseButton.addTarget(self, action: #selector(increaseAction), for: .touchUpInside)

        // quantityLabel
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(quantityLabel)
        quantityLabel.textColor = .black
        quantityLabel.text = "\(quantity)"
        quantityLabel.font = .systemFont(ofSize: 14)
        
        // decreaseButton
        decreaseButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(decreaseButton)
        decreaseButton.setTitle(Strings.DECREASE_TITLE, for: .normal)
        decreaseButton.layer.cornerRadius = 4
        decreaseButton.backgroundColor = UIColor.gray
        decreaseButton.setTitleColor(.white, for: .normal)
        decreaseButton.addTarget(self, action: #selector(decreaseAction), for: .touchUpInside)
    }
        
    // MARK: - Actions
    @objc func increaseAction(sender: UIButton) {
        quantity += 1
        quantityLabel.text = "\(quantity)"
        onActionEvent?(quantity)
    }
    
    @objc func decreaseAction(sender: UIButton) {
        quantity -= 1
        onActionEvent?(quantity)
        if quantity < 1 {
            quantity = 1
        }
        quantityLabel.text = "\(quantity)"
    }

}
