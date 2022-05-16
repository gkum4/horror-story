//
//  RealityKit+.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 16/05/22.
//

import RealityKit
import Metal

extension RealityKit.ARView.PostProcessContext {
    // Returns the output texture, ensuring that the pixel format is
    // appropriate for the current device's GPU.
    var compatibleTargetTexture: MTLTexture! {
        if self.device.supportsFamily(.apple2) {
            return targetColorTexture
        } else {
            return targetColorTexture.makeTextureView(pixelFormat: .bgra8Unorm)!
        }
    }
}
