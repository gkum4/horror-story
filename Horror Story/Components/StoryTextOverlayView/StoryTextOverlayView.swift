//
//  StoryTextOverlayView.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 22/05/22.
//

import UIKit

class StoryTextOverlayView: UIView {
    private lazy var scrollView: UIScrollView = {
        let uiScrollView = UIScrollView()
        uiScrollView.translatesAutoresizingMaskIntoConstraints = false
        return uiScrollView
    }()
    
    private lazy var contentView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var textLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        uiLabel.text = """
        Em 2018 um historiador digital chamado Eduardo Martinelli descobriu uma carta, em um apartamento abandonado na cidade de Campinas. Conhecida por atividades sobrenaturais e lendas urbanas, Campinas sempre chamou muita atenção de historiadores, investigadores, entusiastas de tecnologia e curiosos.

        De fato, muitos eventos inexplicáveis e crimes sem respostas aconteceram na região, e não se sabe a causa, muito menos há indícios concretos dos acontecimentos. Há apenas um padrão: todas as pessoas que desapareceram tiveram um contato com um artefato digital não identificado.

        Eduardo Martinelli encontrou essa carta, a única pista deixada em um dos locais, e fez registros em seus cadernos de pesquisas da Universidade Federal de São Carlos. Dias depois de sua descoberta, da mesma forma que as outras pessoas, Eduardo desapareceu, sem deixar vestígios.

        Dando continuidade a pesquisa realizada até então, uma equipe de desenvolvedores seguiu todas as instruções deixadas pelo seu professor. Havia uma lista de tarefas e exigências a serem seguidas, que tangibilizariam a descoberta feita antes de seu sumiço. A promessa, é que a aplicação digital construída levaria seus usuários a uma explicação concreta dos fatos ocorridos na cidade Campinas.

        O que você irá experienciar não é uma simulação, e sim, um contato direto com a verdade. Siga as instruções e descubra o resultado da investigação.
        

        Leia em voz alta a última instrução deixada por Eduardo Martinelli para iniciar o contato.

        “Um aplicativo você irá baixar, e com assiduidade ele você vai usar. Ao aceite, cuidado você deve tomar. A melhor experiência de uso você terá, mas dentro de uma ilusão você viverá.”
        """
        uiLabel.numberOfLines = 0
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 15
        self.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
        setupSubviews()
    }
    
    private func setupSubviews() {
        self.addSubview(scrollView)
        setupScrollView()
    }
    
    private func setupScrollView() {
        scrollView.addSubview(contentView)
        setupScrollViewConstraints()
        
        setupContentView()
    }
    
    private func setupContentView() {
        setupContentViewConstraints()
        
        contentView.addSubview(textLabel)
        setupTextLabelConstraints()
    }
    
    private func setupScrollViewConstraints() {
        let scrollViewConstraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
    }
    
    private func setupContentViewConstraints() {
        let contentViewConstraints: [NSLayoutConstraint] = [
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(contentViewConstraints)
    }
    
    private func setupTextLabelConstraints() {
        let textLabelConstraints: [NSLayoutConstraint] = [
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(textLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
