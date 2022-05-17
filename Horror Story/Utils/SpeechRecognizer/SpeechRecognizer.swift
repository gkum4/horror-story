//
//  SpeechRecognizer.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 16/05/22.
//

import Speech
import AVFoundation

protocol SpeechRecognizerDelegate {
    func speechCallback(speech: String)
}

class SpeechRecognizer {
    // MARK: Properties
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "pt-BR"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    private var delegate: SpeechRecognizerDelegate!
    
    init(delegate: SpeechRecognizerDelegate) {
        self.delegate = delegate
    }
    
    func startRecording() throws {
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object")
        }
        recognitionRequest.shouldReportPartialResults = true
        recognitionRequest.requiresOnDeviceRecognition = true
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [self] result, error in
            if error != nil {
                print("** ERROR in recognitionTask")
                
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
            
            //Result
            guard let result = result else {
                print("No result found")
                return
            }
            
//            print("Text \(result.bestTranscription.formattedString)")
            self.delegate.speechCallback(speech: result.bestTranscription.formattedString)
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: recordingFormat
        ) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
}
