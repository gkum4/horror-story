//
//  StartViewController.swift
//  Horror Story
//
//  Created by Bruna Naomi Yamanaka Silva on 23/05/22.
//

import UIKit
import ImageIO

class StartViewController: UIViewController {
    let videoHolder = UIView()
    var videoPlayerLooped = VideoPlayerLooped()
    var buttonView: UIView {
        let uiView = UIView()
        return uiView
    }
    private lazy var startButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle("Iniciar", for: .normal)
        uiButton.setTitleColor(UIColor.systemBlue, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 17)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        //uiButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
//        uiButton.layer.borderWidth = 4
//        uiButton.layer.borderColor = UIColor.tertiarySystemFill.cgColor
//        uiButton.layer.cornerRadius = 10
        uiButton.addAction(for: .touchUpInside, startButtonPress)
        return uiButton
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
        videoHolder.translatesAutoresizingMaskIntoConstraints = false
        videoHolder.frame = CGRect(x: 0, y: 0, width: 400, height: 750)
        videoPlayerLooped.playVideo(fileName: "logo", inView: videoHolder)
        view.addSubview(videoHolder)
        view.addSubview(startButton)
        addContraints()
    }

    private func addContraints(){
        var constraints = [NSLayoutConstraint]()
        // add
        constraints.append(videoHolder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(videoHolder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(videoHolder.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(videoHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        constraints.append(startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200))
        // active
        NSLayoutConstraint.activate(constraints)
    }

    private func startButtonPress() {
        self.dismiss(animated: true, completion: nil)
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
