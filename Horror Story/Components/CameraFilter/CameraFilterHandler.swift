//
//  CameraFilterHandler.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 12/05/22.
//

import CoreImage.CIFilterBuiltins
import UIKit

class CameraFilterHandler {
    func applyFilter(image: CIImage) -> CIImage {
        let sepiaImage = getSepiaImage(from: image)
        let noisyImage = getNoisyImage(from: sepiaImage)
        
        return noisyImage
    }
    
    private func getSepiaImage(from image: CIImage) -> CIImage {
        let filter = CIFilter.sepiaTone()
        filter.intensity = 1
        filter.inputImage = image
        
        guard let outputImage = filter.outputImage else {
            print("Error applying SepiaToneFilter")
            return CIImage()
        }
        
        return outputImage
    }
    
    private func getNoisyImage(from image: CIImage) -> CIImage {
        let noiseFilter = CIFilter.randomGenerator()
        guard let noiseImage = noiseFilter.outputImage else {
            print("Error generating noiseImage")
            return CIImage()
        }
        
        let whitenVector = CIVector(x: 0, y: CGFloat.random(in: 0...1), z: 0, w: 0)
        let fineGrain = CIVector(x:0, y: CGFloat.random(in: 0...0.005), z: 0, w: 0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        let whiteningFilter = CIFilter.colorMatrix()
        whiteningFilter.inputImage = noiseImage
        whiteningFilter.rVector = whitenVector
        whiteningFilter.gVector = whitenVector
        whiteningFilter.bVector = whitenVector
        whiteningFilter.aVector = fineGrain
        whiteningFilter.biasVector = zeroVector
        
        guard let whiteSpecks = whiteningFilter.outputImage else {
            print("Error generating white specs")
            return CIImage()
        }
        
        let speckCompositor = CIFilter.sourceOverCompositing()
        speckCompositor.inputImage = whiteSpecks
        speckCompositor.backgroundImage = image
        
        guard let speckledImage = speckCompositor.outputImage else {
            print("Error generating whiteSpecks")
            return CIImage()
        }
        
        let verticalScale = CGAffineTransform(scaleX: CGFloat.random(in: 0...1.5), y: CGFloat.random(in: 20...25))
        let transformedNoise = noiseImage.transformed(by: verticalScale)
        
        let darkenVector = CIVector(x: CGFloat.random(in: 2...4), y: 0, z: 0, w: 0)
        let darkenBias = CIVector(x: 0, y: CGFloat.random(in: 0...1), z: CGFloat.random(in: 0...1), w: CGFloat.random(in: 0...1))
        
        let darkeningFilter = CIFilter.colorMatrix()
        darkeningFilter.inputImage = transformedNoise
        darkeningFilter.rVector = darkenVector
        darkeningFilter.gVector = zeroVector
        darkeningFilter.bVector = zeroVector
        darkeningFilter.aVector = zeroVector
        darkeningFilter.biasVector = darkenBias
        
        guard let randomScratches = darkeningFilter.outputImage else {
            print("Error generating randomScratches")
            return CIImage()
        }
        
        let grayscaleFilter = CIFilter.minimumComponent()
        grayscaleFilter.inputImage = randomScratches
        
        guard let darkScratches = grayscaleFilter.outputImage else {
            print("Error generating darkScratches")
            return CIImage()
        }
        
        let oldFilmCompositor = CIFilter.multiplyCompositing()
        oldFilmCompositor.inputImage = darkScratches
        oldFilmCompositor.backgroundImage = speckledImage
        
        guard let oldFilmImage = oldFilmCompositor.outputImage else {
            print("Error genearting oldFilmImage")
            return CIImage()
        }
        
        let finalImage = oldFilmImage.cropped(to: image.extent)
        
        return finalImage
    }
}
