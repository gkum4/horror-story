//
//  OnboardingWarningView.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 20/05/22.
//

import UIKit

class OnboardingWarningView: UIView {
    private lazy var popupView: UIView = {
        let uiView = UIView()
        uiView.layer.borderWidth = 4
        uiView.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        uiView.layer.cornerRadius = 10
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var warningLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        uiLabel.text = "Aviso"
        uiLabel.textColor = .systemYellow
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    private lazy var warningIcon: UIImageView = {
        let uiImageView = UIImageView()
        
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 28))
        let iconImage = UIImage(systemName: "exclamationmark.triangle.fill", withConfiguration: iconConfig)
        
        uiImageView.image = iconImage
        uiImageView.tintColor = .systemYellow
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()
    
    private lazy var mainText: UILabel = {
        let uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        uiLabel.text = """
        Este aplicativo foi desenvolvido por uma equipe de estudantes, seguindo instruções de seu professor desaparecido.
        
        As instruções não revelam as consequências de uso, apenas citam um possível contato com o sobrenatural, uma outra dimensão.
        
        As consequências causadas pelo uso deste aplicativo são de sua total responsabilidade. Leia os termos abaixo e aceite as condições para continuar.
        """
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.numberOfLines = 0
        return uiLabel
    }()
    
    private lazy var conditionsText: UILabel = {
        let uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        uiLabel.text = """
        Condições
        
        • Não armazenamos seus dados pessoais
        • Não armazenamos sua localização
        • Não armazenamos imagens e gravações
        • Não nos responsabilizamos pela sua segurança psicológica
        """
        uiLabel.textColor = .secondaryLabel
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.numberOfLines = 0
        return uiLabel
    }()
    
    lazy var notAcceptButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle("Não aceito", for: .normal)
        uiButton.setTitleColor(UIColor.systemBlue, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 15)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.addAction(for: .touchDown, {
            uiButton.alpha = 0.7
        })
        uiButton.addAction(for: .touchUpInside, {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
                uiButton.alpha = 1
            })
        })
        uiButton.addAction(for: .touchUpOutside, {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
                uiButton.alpha = 1
            })
        })
        
        return uiButton
    }()
    
    lazy var acceptButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle("Aceito as condições", for: .normal)
        uiButton.setTitleColor(UIColor.systemBlue, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.addAction(for: .touchDown, {
            uiButton.alpha = 0.7
        })
        uiButton.addAction(for: .touchUpInside, {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
                uiButton.alpha = 1
            })
        })
        uiButton.addAction(for: .touchUpOutside, {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
                uiButton.alpha = 1
            })
        })
        
        return uiButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        self.addSubview(popupView)
        addPopupViewStrokes()
        popupView.addSubview(warningLabel)
        popupView.addSubview(warningIcon)
        popupView.addSubview(mainText)
        popupView.addSubview(conditionsText)
        popupView.addSubview(notAcceptButton)
        popupView.addSubview(acceptButton)
    }
    
    private func addPopupViewStrokes() {
        let topStroke = UIView()
        topStroke.backgroundColor = .tertiarySystemFill
        topStroke.translatesAutoresizingMaskIntoConstraints = false
        let bottomStroke = UIView()
        bottomStroke.backgroundColor = .tertiarySystemFill
        bottomStroke.translatesAutoresizingMaskIntoConstraints = false
        let middleStroke = UIView()
        middleStroke.backgroundColor = .tertiarySystemFill
        middleStroke.translatesAutoresizingMaskIntoConstraints = false
        
        popupView.addSubview(topStroke)
        popupView.addSubview(bottomStroke)
        popupView.addSubview(middleStroke)
        
        let topStrokeConstraints: [NSLayoutConstraint] = [
            topStroke.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 4),
            topStroke.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -4),
            topStroke.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 60),
            topStroke.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(topStrokeConstraints)
        
        let bottomStrokeConstraints: [NSLayoutConstraint] = [
            bottomStroke.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 4),
            bottomStroke.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -4),
            bottomStroke.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -62),
            bottomStroke.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(bottomStrokeConstraints)
        
        let middleStrokeConstraints: [NSLayoutConstraint] = [
            middleStroke.topAnchor.constraint(equalTo: bottomStroke.bottomAnchor),
            middleStroke.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -4),
            middleStroke.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            middleStroke.widthAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(middleStrokeConstraints)
    }
    
    private func setupConstraints() {
        setupPopupViewConstraints()
        setupWarningLabelConstraints()
        setupWarningIconConstraints()
        setupMainTextConstraints()
        setupConditionsTextConstraints()
        setupNotAcceptButtonConstraints()
        setupAcceptButtonConstraints()
    }
    
    private func setupPopupViewConstraints() {
        let popupViewConstraints: [NSLayoutConstraint] = [
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            popupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            popupView.heightAnchor.constraint(greaterThanOrEqualToConstant: 521)
        ]
        NSLayoutConstraint.activate(popupViewConstraints)
    }
    
    private func setupWarningLabelConstraints() {
        let warningLabelConstraints: [NSLayoutConstraint] = [
            warningLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 13),
            warningLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(warningLabelConstraints)
    }
    
    private func setupWarningIconConstraints() {
        let warningIconConstraints: [NSLayoutConstraint] = [
            warningIcon.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -13),
            warningIcon.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15),
        ]
        NSLayoutConstraint.activate(warningIconConstraints)
    }
    
    private func setupMainTextConstraints() {
        let mainTextConstraints: [NSLayoutConstraint] = [
            mainText.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            mainText.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 81),
            mainText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 13),
            mainText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -13),
        ]
        NSLayoutConstraint.activate(mainTextConstraints)
    }
    
    private func setupConditionsTextConstraints() {
        let conditionsTextConstraints: [NSLayoutConstraint] = [
            conditionsText.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            conditionsText.topAnchor.constraint(equalTo: mainText.bottomAnchor, constant: 30),
            conditionsText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 13),
            conditionsText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -13),
            conditionsText.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -92),
        ]
        NSLayoutConstraint.activate(conditionsTextConstraints)
    }
    
    private func setupNotAcceptButtonConstraints() {
        let notAcceptButtonConstraints: [NSLayoutConstraint] = [
            notAcceptButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 48),
            notAcceptButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -18)
        ]
        NSLayoutConstraint.activate(notAcceptButtonConstraints)
    }
    
    private func setupAcceptButtonConstraints() {
        let acceptButtonConstraints: [NSLayoutConstraint] = [
            acceptButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -14),
            acceptButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -18)
        ]
        NSLayoutConstraint.activate(acceptButtonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
