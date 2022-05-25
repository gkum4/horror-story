//
//  ARCameraGeometryManager.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 20/05/22.
//

import ARKit
import RealityKit

class ARCameraGeometryManager {
    private let userPosition: SIMD3<Float>
    private let entityPosition: SIMD3<Float>
    private let directionRepresentationPos: SIMD3<Float>
    
    let entityDistanceFromUser: Float
    let entityDistanceFromDirectionRepresentationPos: Float
    
    init(camera: ARCamera, entity: Entity) {
        userPosition = SIMD3<Float>(
            x: camera.transform.columns.3.x,
            y: camera.transform.columns.3.y,
            z: camera.transform.columns.3.z
        )
        entityPosition = entity.position(relativeTo: nil)

        let userPointingDirection = SIMD3<Float>(
            x: -camera.transform.columns.2.x,
            y: -camera.transform.columns.2.y,
            z: -camera.transform.columns.2.z
        )
        
        directionRepresentationPos = SIMD3<Float>(
            x: userPointingDirection.x + userPosition.x,
            y: userPointingDirection.y + userPosition.y,
            z: userPointingDirection.z + userPosition.z
        )

        entityDistanceFromUser = sqrt(
            pow(entityPosition.x - userPosition.x, 2) +
            pow(entityPosition.y - userPosition.y, 2) +
            pow(entityPosition.z - userPosition.z, 2)
        )
        
        entityDistanceFromDirectionRepresentationPos = sqrt(
            pow(entityPosition.x - directionRepresentationPos.x, 2) +
            pow(entityPosition.y - directionRepresentationPos.y, 2) +
            pow(entityPosition.z - directionRepresentationPos.z, 2)
        )
    }
    
    
    func checkIfIsPointingAtEntity() -> Bool {
        if entityDistanceFromUser > entityDistanceFromDirectionRepresentationPos {
            return true
        }
        
        return false
    }
    
    func getEntityDistanceFromUser() -> Float {
        return entityDistanceFromUser
    }
    
    func getPointingAtEntityIntensity() -> Float {
        if !checkIfIsPointingAtEntity() {
            return 0
        }
        
        if entityDistanceFromUser <= 1 {
            return 1.0
        }
        return entityDistanceFromUser - entityDistanceFromDirectionRepresentationPos
    }
}
