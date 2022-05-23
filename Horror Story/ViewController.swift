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
    private lazy var speechRecognizer = SpeechRecognizer(delegate: self)
    private lazy var onboardingWarningView: OnboardingWarningView = {
        let warningView = OnboardingWarningView(frame: self.view.frame)
        warningView.notAcceptButton.addAction(for: .touchUpInside, notAcceptTermsPress)
        warningView.acceptButton.addAction(for: .touchUpInside, acceptTermsPress)
        return warningView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(onboardingWarningView)
    }
    
    private func setupConstraints() {
    }
    
    private func startSpeechRecognizer() {
        do {
            try speechRecognizer.startRecording()
        } catch {
            print("Error initializing speech recognizer recording")
        }
    }
    
    private func stopSpeechRecognizer() {
        do {
            try speechRecognizer.audioEngine.stop()
        } catch {
            print("Error initializing speech recognizer recording")
        }
    }
    
    func speechCallback(speech: String) {
        
    }
    
    func notAcceptTermsPress() {
        // TODO: voltar para tela inicial
        print("not accept")
    }
    
    func acceptTermsPress() {
        
    }
}

