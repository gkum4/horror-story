//
//  DistanceIntensityManager.swift
//  Horror Story
//
//  Created by Guilerme Barciki on 23/05/22.
//

import ARKit
import RealityKit

class DistanceIntensityManager {
    var distanceValues = [Float]()
    init(camera: ARCamera, entities: [Entity]) {
        for entity in entities {
           let arCameraGeometryManager = ARCameraGeometryManager(
                camera: camera,
                entity: entity
            )
            let distanceIntensity = arCameraGeometryManager.getPointingAtEntityIntensity()
            distanceValues.append(distanceIntensity)
        }
    }
    
    func getHighestValue() -> Float {
        return distanceValues.max() ?? 0
    }
}
