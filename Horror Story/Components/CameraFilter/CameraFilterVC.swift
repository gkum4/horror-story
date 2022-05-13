//
//  CameraFilterVC.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 11/05/22.
//

import UIKit
import AVFoundation

class CameraFilterVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    lazy var imageView: UIImageView = {
        return UIImageView(frame: self.view.frame)
    }()
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(
            session: captureSession
        )
        
        preview.videoGravity = .resizeAspectFill
        preview.frame = self.view.frame
        
        return preview
    }()
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let captureSession = AVCaptureSession()
    
    private lazy var filterHandler = CameraFilterHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubViews()
        self.setCameraInput()
        self.setCameraOutput()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startCamera()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopCamera()
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    private func setupSubViews() {
        self.view.addSubview(imageView)
    }
    
    private func startCamera() {
        videoDataOutput.setSampleBufferDelegate(
            self,
            queue: DispatchQueue(label: "camera_frame_processing_queue")
        )
        captureSession.startRunning()
    }
    
    private func stopCamera() {
        videoDataOutput.setSampleBufferDelegate(nil, queue: nil)
        captureSession.stopRunning()
    }
    
    private func setCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back
        ).devices.first else {
            fatalError("No back camera device found.")
        }

        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: device)
        } catch {
            print("Failed to load video input")
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            print("Could not add videoInput to captureSession")
        }
    }
    
    func setCameraOutput() {
        videoDataOutput.alwaysDiscardsLateVideoFrames = true

        videoDataOutput.setSampleBufferDelegate(
            self,
            queue: DispatchQueue(label: "camera_frame_processing_queue")
        )

        captureSession.addOutput(videoDataOutput)

        guard let connection = videoDataOutput.connection(
            with: AVMediaType.video
        ), connection.isVideoOrientationSupported else {
            return
        }
        connection.videoOrientation = .portrait
    }
    
    // MARK: AVCaptureVideo Delegate
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        guard let pixelBuffer = pixelBuffer else {
            return
        }
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let filteredImage = filterHandler.applyFilter(image: cameraImage)
        
        DispatchQueue.main.async {
            self.imageView.image = UIImage(ciImage: filteredImage)
        }
        
    }
}
