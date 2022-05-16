//
//  CameraFilterVC.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 11/05/22.
//

import UIKit
import AVFoundation
import RealityKit

class CameraFilterVC: UIViewController {
    private lazy var arView = ARView(
        frame: view.frame,
        cameraMode: .ar,
        automaticallyConfigureSession: true
    )
    
    private var filtersCIContext: CIContext?
    private lazy var filterHandler = CameraFilterHandler()
    private lazy var sepiaToneFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .sepiaTone
    )
    private lazy var darkScratchesFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .darkScratches
    )
    private lazy var whiteSpecksFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .whiteSpecks
    )
    private lazy var colorInvertFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .colorInvert
    )
    private lazy var redIncreaseFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .redIncrease
    )
    private lazy var bloomFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .bloom
    )
    private lazy var noirFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .noir
    )
    private lazy var blinkFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .blink
    )
    private lazy var colorGlitchFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .colorGlitch
    )
    private lazy var pixellateFilterButton = ApplyFilterButton(
        cameraFilterHandler: filterHandler,
        filter: .pixellate
    )
    private lazy var filterButtons: [ApplyFilterButton] = [
        sepiaToneFilterButton,
        darkScratchesFilterButton,
        whiteSpecksFilterButton,
        colorInvertFilterButton,
        redIncreaseFilterButton,
        bloomFilterButton,
        noirFilterButton,
        blinkFilterButton,
        colorGlitchFilterButton,
        pixellateFilterButton
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupARView()
        self.setupSubViews()
    }
    
    private func setupSubViews() {
        view.addSubview(arView)
        filterButtons.forEach({ self.view.addSubview($0) })
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let firstButtonConstraints: [NSLayoutConstraint] = [
            filterButtons[0].topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: 50
            ),
            filterButtons[0].leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 20
            )
        ]
        NSLayoutConstraint.activate(firstButtonConstraints)
        
        for (i, filterButton) in filterButtons.enumerated() {
            filterButton.translatesAutoresizingMaskIntoConstraints = false
            
            if i == 0 {
                continue
            }
            
            let buttonConstraints: [NSLayoutConstraint] = [
                filterButton.topAnchor.constraint(
                    equalTo: filterButtons[i-1].bottomAnchor,
                    constant: 20
                ),
                filterButton.leadingAnchor.constraint(
                    equalTo: self.view.leadingAnchor,
                    constant: 20
                )
            ]
            NSLayoutConstraint.activate(buttonConstraints)
        }
    }
    
    private func setupARView() {
        setupCameraFilters()
    }
    
    private func setupCameraFilters() {
        arView.renderCallbacks.prepareWithDevice = { device in
            self.filtersCIContext = CIContext(mtlDevice: device)
        }
        arView.renderCallbacks.postProcess = postProcessWithCoreImage
    }
    
    private func postProcessWithCoreImage(context: ARView.PostProcessContext) {
        guard let frameImage = CIImage(mtlTexture: context.sourceColorTexture) else {
            fatalError("Unable to create a CIImage from sourceColorTexture.")
        }
        
        let filteredImage = filterHandler.applyFilter(image: frameImage)

        // Create a render destination and render the filter to the context's command buffer.
        let destination = CIRenderDestination(
            mtlTexture: context.compatibleTargetTexture,
            commandBuffer: context.commandBuffer
        )
        destination.isFlipped = false
        
        guard let ciContext = self.filtersCIContext else {
            fatalError("Error in setup of ciContext.")
        }
        
        _ = try? ciContext.startTask(toRender: filteredImage, to: destination)
    }
}
