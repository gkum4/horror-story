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
    private lazy var onboardingWarning: OnboardingWarningView = {
        let onboardingWarningView = OnboardingWarningView(frame: self.view.frame)
        onboardingWarningView.notAcceptButton.addAction(for: .touchUpInside, notAcceptTermsPress)
        onboardingWarningView.acceptButton.addAction(for: .touchUpInside, acceptTermsPress)
        return onboardingWarningView
    }()
    private lazy var storyTextOverlay: StoryTextOverlayView = {
        let storyTextOverlayView = StoryTextOverlayView(frame: self.view.frame)
        storyTextOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return storyTextOverlayView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(onboardingWarning)
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
        print(speech)
        if speech.contains("ilusão") && speech.contains("viverá") {
            stopSpeechRecognizer()
            
            storyTextOverlay.removeFromSuperview()
        }
    }
    
    func notAcceptTermsPress() {
        // TODO: voltar para tela inicial
        print("not accept")
    }
    
    func acceptTermsPress() {
        UIView.animate(withDuration: 1, animations: {
            self.onboardingWarning.alpha = 0
        }, completion: { _ in
            self.onboardingWarning.removeFromSuperview()
            
            self.view.addSubview(self.cameraView)
            self.storyTextOverlay.alpha = 0
            self.setupStoryTextOverlay()
            UIView.animate(withDuration: 1, animations: {
                self.storyTextOverlay.alpha = 1
            }, completion: { _ in
                self.startSpeechRecognizer()
            })
        })
        
        
    }
    
    func setupStoryTextOverlay() {
        self.view.addSubview(storyTextOverlay)
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        let storyTextOverlayConstraints: [NSLayoutConstraint] = [
            storyTextOverlay.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 20),
            storyTextOverlay.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -20),
            storyTextOverlay.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 14),
            storyTextOverlay.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -14),
        ]
        NSLayoutConstraint.activate(storyTextOverlayConstraints)
    }
}

