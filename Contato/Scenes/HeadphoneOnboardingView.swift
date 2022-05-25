//
//  HeadphoneOnboardingView.swift
//  Horror Story
//
//  Created by Guilerme Barciki on 22/05/22.
//

import Foundation
import UIKit

class HeadPhoneOnboardingView: UIView {
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Para uma melhor experiência,\nuse fones com Spatial Audio"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var subInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AirPods Pro, AirPods Max ou similares"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var headPhonesImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "headphones-onboarding")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var spacer = UIStackView()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Entendi", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 270, height: 325))
        setupUI()
    }
    
    private func setupUI() {
        addSubview(stackView)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.layer.opacity = 0.75
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 325),
            self.widthAnchor.constraint(equalToConstant: 270)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
        ])
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(subInfoLabel)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(headPhonesImage)
        stackView.addArrangedSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
