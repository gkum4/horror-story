//
//  ViewController.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 04/05/22.
//

import UIKit
import RealityKit

class ViewController: UIViewController, SpeechRecognizerDelegate {
    private lazy var cameraView = CameraView(
        frame: view.frame,
        cameraMode: .ar,
        automaticallyConfigureSession: true
    )
    private lazy var label: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Diga: \"Eu quero contato\""
        uiLabel.font = .systemFont(ofSize: 18)
        return uiLabel
    }()
    private lazy var speechRecognizer = SpeechRecognizer(delegate: self)
    private var startedHorror = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.applyOldFilm()
        setupSubviews()
        startSpeechRecognizer()
    }

    private func setupSubviews() {
        view.addSubview(cameraView)
        view.addSubview(label)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints: [NSLayoutConstraint] = [
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    private func startSpeechRecognizer() {
        do {
            try speechRecognizer.startRecording()
        } catch {
            print("Error initializing speech recognizer recording")
        }
    }
    
    func speechCallback(speech: String) {
        if startedHorror {
            return
        }
        
        if speech.contains("contato") {
            cameraView.applyPixellate()
            label.text = "Diga: \"Eu aceito as consequências\""
            return
        }
        
        if speech.contains("consequências") {
            cameraView.applyGlitch()
            label.text = "Diga: \"Me mostre a verdade\""
//            cameraView.loadScene()
            return
        }
        
        if speech.contains("verdade") {
            cameraView.removeAllFilters()
            cameraView.applyInverter()
            label.text = "MUAHAHAHAHA"
            startedHorror = true
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
                self.cameraView.removeAllFilters()
                self.cameraView.applyOldFilm()
                self.cameraView.applyRedIncrease()
                self.cameraView.applyBlink()
                self.cameraView.applyPixellate()
                self.cameraView.applyGlitch()
            })
            
            return
        }
    }
}

