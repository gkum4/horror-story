//
//  RealityKitTestViewController.swift
//  Horror Story
//
//  Created by Guilerme Barciki on 15/05/22.
//

import Foundation
import UIKit
import RealityKit
import ARKit
import Accelerate

class  RealityKitTestViewController: UIViewController {
    
    
//    var anchor: HorrorSceneTest.Box!
    var arView: ARView!
    override func viewDidLoad() {
//        self.view.backgroundColor = .green
        arView = ARView(frame: view.frame,
                        cameraMode: .ar,
                            automaticallyConfigureSession: true)
//        //----
//        var sphereMaterial = SimpleMaterial()
//        sphereMaterial.metallic = MaterialScalarParameter(floatLiteral: 1)
//        sphereMaterial.roughness = MaterialScalarParameter(floatLiteral: 1)
//        sphereMaterial.tintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8)
//        let sphereEntity = ModelEntity(mesh: .generateSphere(radius: 0.5),
//                                       materials: [sphereMaterial])
//        let sphereAnchor = AnchorEntity(world: SIMD3<Float>(0, 0, -4))
//        sphereAnchor.addChild(sphereEntity)
//        //----
        view.addSubview(arView)
//
//        anchor = try! HorrorSceneTest.loadBox()
//
//
////        arView.scene.addAnchor(sphereAnchor)
////        guard let sceneElement = try? HorrorSceneTest.loadBox() else {
////            print("sceneElement Fail")
////            return
////        }
//
////        anchor.generateCollisionShapes(recursive: true)
////        let config = ARWorldTrackingConfiguration()
////        config.planeDetection = .horizontal
////        arView.session.run(config)
//
//        arView.scene.anchors.append(anchor)
//        arView.session.run(ARWorldTrackingConfiguration())
//
//        sphereEntity.setSound(name: "som1.wav")
        
        do {
            let boxAnchor = try HorrorSceneTest.loadBox()
            arView.scene.anchors.append(boxAnchor)
            print("carregou")
            // ...
        } catch {
            // handle error
        }
        
//        guard let boxAnchor = try? HorrorSceneTest.loadBox() else {
//            print("n rolou")
//            return
//        }
        
        
                
    }
}

extension Entity {
    func setSound(name: String) {
        do {
          let resource = try AudioFileResource.load(named: name, in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: true)
          
          let audioController = self.prepareAudio(resource)
          audioController.play()
         
          // If you want to start playing right away, you can replace lines 7-8 with line 11 below
          // let audioController = entity.playAudio(resource)
        } catch {
          print("Error loading audio file")
        }
    }
}
