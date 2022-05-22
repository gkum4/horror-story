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
        return label
    }()
    
    lazy var headPhonesImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(stackView)
        NSLayoutConstraint.activate(<#T##constraints: [NSLayoutConstraint]##[NSLayoutConstraint]#>)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
