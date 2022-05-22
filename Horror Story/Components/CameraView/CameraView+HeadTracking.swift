//
//  CameraView+HeadTracking.swift
//  Horror Story
//
//  Created by Guilerme Barciki on 19/05/22.
//

import Foundation
import CoreMotion
import RealityKit

class HeadTrackingManager: NSObject, CMHeadphoneMotionManagerDelegate {
    let headMotionManager = CMHeadphoneMotionManager()
    let parentARView: ARView
    let queue = OperationQueue()
    var position = simd_float4x4()
    var parentListener: Entity?
    
    init(parentARView: ARView) {
        self.parentARView = parentARView
        super.init()
        
        parentListener = Entity()
        let listenerAnchor = AnchorEntity(world: .zero)
        listenerAnchor.addChild(parentListener!)
        parentARView.scene.anchors.append(listenerAnchor)
        parentARView.audioListener = parentListener
        
        headMotionManager.delegate = self
        
        guard headMotionManager.isDeviceMotionAvailable else {
            return
        }
        headMotionManager.startDeviceMotionUpdates(to: queue, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
            
            self?.handleMotion(arView: self?.parentARView, motion: motion)
       
        })
    }
    
    private func handleMotion(arView: ARView?, motion: CMDeviceMotion) {
        
        var position = simd_float4x4()
        position.columns.0 = simd_make_float4(-1.0, 0.0, 0.0, 0.0)
        position.columns.1 = simd_make_float4(0.0, 1.0, 0.0, 0.0)
        position.columns.2 = simd_make_float4(0.0, 0.0, -1.0, 0.0)
        position.columns.3 = simd_make_float4(0.0, 0.0, 0.0, 1.0)
        parentARView.audioListener?.transform = Transform(matrix: position)
        
        let cameraFrame = parentARView.session.currentFrame
        guard let cameraFrame = cameraFrame else {
             print("camera frame nil")
            return
        }
        let cameraTransform: simd_float4x4 = cameraFrame.camera.transform
        let c3 = cameraTransform.columns.3
        let attitude = motion.attitude
        
        
        
        
        let airMatrix = simd_float4x4(simd_quatf(angle: Float(-(attitude.yaw)), axis: float3(0, 1, 0)))
        
        
        let am0 = airMatrix.columns.0
        let am1 = airMatrix.columns.1
        let am2 = airMatrix.columns.2
        
        position = simd_float4x4([am0.x, am1.x, am2.x, c3.x], //
                                 [am0.y, am1.y, am2.y, c3.y],
                                 [am0.z, am1.z, am2.z, c3.z],
                                 [am0.w, am1.w, am2.w , c3.w])
        position.columns.3 = simd_float4(c3.x, c3.y, c3.z, c3.w)
        
        parentListener?.transform = Transform(matrix: position)
        
        print("parent listener: \(parentListener)")
    }
}


