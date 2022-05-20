//
//  OnboardingWarningView.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 20/05/22.
//

import UIKit

class OnboardingWarningView: UIView {
    private lazy var warningLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        uiLabel.text = "Aviso"
        uiLabel.textColor = .systemYellow
        return uiLabel
    }()
    
    private lazy var mainText: UILabel = {
        let uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        uiLabel.text = """
        Este aplicativo foi desenvolvido por uma equipe de estudantes, seguindo instruções de seu professor desaparecido.
        
        As instruções não revelam as consequências de uso, apenas citam um possível contato com o sobrenatural, uma outra dimensão.
        
        As consequências causadas pelo uso deste aplicativo são de sua total responsabilidade. Leia os termos abaixo e aceite as condições para continuar.
        """
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
        return uiLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
