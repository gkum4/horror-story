//
//  CameraView.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 16/05/22.
//

import RealityKit
import CoreImage
import UIKit
import ARKit

class CameraView: ARView {
    private var filtersCIContext: CIContext?
    private lazy var filterHandler = CameraFilterHandler()
    var headTrackingManager: HeadTrackingManager?
    let entityNames = ["a2", "bebe"]
    
    override init(
        frame frameRect: CGRect,
        cameraMode: ARView.CameraMode,
        automaticallyConfigureSession: Bool
    ) {
        super.init(
            frame: frameRect,
            cameraMode: cameraMode,
            automaticallyConfigureSession: automaticallyConfigureSession
        )
        
        headTrackingManager = HeadTrackingManager(parentARView: self)
        self.renderCallbacks.prepareWithDevice = { device in
            self.filtersCIContext = CIContext(mtlDevice: device)
        }
        self.renderCallbacks.postProcess = postProcessARViewFrames
        
        
        loadScene()
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func applyOldFilm() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .sepiaTone }) {
            return
        }
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .darkScratches }) {
            return
        }
        
        filterHandler.filtersToApply.append(.sepiaTone)
        filterHandler.filtersToApply.append(.darkScratches)
    }
    
    func applyPixellate() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .pixellate }) {
            return
        }
        
        filterHandler.filtersToApply.append(.pixellate)
    }
    
    func applyGlitch() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .colorGlitch }) {
            return
        }
        
        filterHandler.filtersToApply.append(.colorGlitch)
    }
    
    func applyInverter() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .colorInvert }) {
            return
        }
        
        filterHandler.filtersToApply.append(.colorInvert)
    }
    
    func applyBlink() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .blink }) {
            return
        }
        
        filterHandler.filtersToApply.append(.blink)
    }
    
    func applyNegativeBlink() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .negativeBlink }) {
            return
        }
        
        filterHandler.filtersToApply.append(.negativeBlink)
    }
    
    func applyRedIncrease() {
        if let _ = filterHandler.filtersToApply.first(where: { $0 == .redIncrease }) {
            return
        }
        
        filterHandler.filtersToApply.append(.redIncrease)
    }
    
    func removeAllFilters() {
        filterHandler.filtersToApply = []
    }
    
    func loadScene() {
        do {
            let boxAnchor = try HorrorSceneTest.loadBox()
            self.scene.anchors.append(boxAnchor)
        } catch {
            // handle error
        }
        
//        var sphereMaterial = SimpleMaterial()
//        sphereMaterial.metallic = MaterialScalarParameter(floatLiteral: 0.5)
//        sphereMaterial.roughness = MaterialScalarParameter(floatLiteral: 0.5)
//        sphereMaterial.color = .init(
//            tint: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8),
//            texture: nil
//        )
//        let sphereEntity = ModelEntity(
//            mesh: .generateSphere(radius: 0.5),
//            materials: [sphereMaterial]
//        )
//
//        let sphereAnchor = AnchorEntity(world: SIMD3<Float>(1, 1, -2))
//        sphereAnchor.addChild(sphereEntity)
//        sphereAnchor.name = "kuma"
//
//        self.scene.addAnchor(sphereAnchor)
    }
    
    private func postProcessARViewFrames(context: ARView.PostProcessContext) {
        for entity in entityNames {
            if let currentFrame = self.session.currentFrame {
                guard let kumaEntity = self.scene.findEntity(named: entity) else {
                    print("kumaEntity not found")
                    return
                }

                let distanceIntensity = ARCameraGeometryManager(
                    camera: currentFrame.camera,
                    entity: kumaEntity
                ).getPointingAtEntityIntensity()

                filterHandler.intensity = CGFloat(distanceIntensity)
            }
        }
        
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

