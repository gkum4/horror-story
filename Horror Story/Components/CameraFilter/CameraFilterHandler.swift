//
//  CameraFilterHandler.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 12/05/22.
//

import CoreImage.CIFilterBuiltins
import UIKit

class CameraFilterHandler {
    var filtersToApply: [Filters] = []
    
    func applyFilter(image: CIImage) -> CIImage {
        var finalImage = image
        
        for filter in filtersToApply {
            switch filter {
            case .sepiaTone:
                finalImage = applySepiaToneFilter(to: finalImage)
            case .darkScratches:
                finalImage = applyDarkScratchesFilter(to: finalImage)
            case .whiteSpecks:
                finalImage = applyWhiteSpecksFilter(to: finalImage)
            case .colorInvert:
                finalImage = applyColorInvertFilter(to: finalImage)
            case .redIncrease:
                finalImage = applyRedIncreaseFilter(to: finalImage)
            case .bloom:
                finalImage = applyBloomFilter(to: finalImage)
            }
        }
        
        return finalImage
    }
    
    enum Filters: String {
        case sepiaTone = "Sepia Tone"
        case darkScratches = "Dark Scratches"
        case whiteSpecks = "White Specks"
        case colorInvert = "Color Invert"
        case redIncrease = "Red Increase"
        case bloom = "Bloom"
    }
    
    private func applySepiaToneFilter(to image: CIImage) -> CIImage {
        let filter = CIFilter.sepiaTone()
        filter.intensity = 1
        filter.inputImage = image
        
        guard let outputImage = filter.outputImage else {
            print("Error applying SepiaToneFilter")
            return CIImage()
        }
        
        return outputImage
    }
    
    private func applyDarkScratchesFilter(to image: CIImage) -> CIImage {
        let noiseImage = getNoiseImage()
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        let verticalScale = CGAffineTransform(scaleX: CGFloat.random(in: 0...1.5), y: CGFloat.random(in: 20...25))
        let transformedNoise = noiseImage.transformed(by: verticalScale)
        
        let darkenVector = CIVector(x: CGFloat.random(in: 2...4), y: 0, z: 0, w: 0)
        let darkenBias = CIVector(x: 0, y: 1, z: 1, w: 1)
        
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
        oldFilmCompositor.backgroundImage = image
        
        guard let oldFilmImage = oldFilmCompositor.outputImage else {
            print("Error genearting oldFilmImage")
            return CIImage()
        }
        
        let finalImage = oldFilmImage.cropped(to: image.extent)
        
        return finalImage
    }
    
    private func applyWhiteSpecksFilter(to image: CIImage) -> CIImage {
        let noiseImage = getNoiseImage()
        
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x:0, y: 0.005, z: 0, w: 0)
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
        
        let finalImage = speckledImage.cropped(to: image.extent)
        
        return finalImage
    }
    
    private func applyColorInvertFilter(to image: CIImage) -> CIImage {
        let colorInvertFilter = CIFilter.colorInvert()
        colorInvertFilter.inputImage = image
        
        guard let colorInvertedImage = colorInvertFilter.outputImage else {
            print("Error generating colorInvertImage")
            return CIImage()
        }
        
        return colorInvertedImage
    }
    
    private func applyRedIncreaseFilter(to image: CIImage) -> CIImage {
//        let colorMatrixFilter = CIFilter.colorMatrix()
//        colorMatrixFilter.inputImage = image
//        colorMatrixFilter.rVector = CIVector(x: 1, y: 0, z: 0, w: 0)
//        colorMatrixFilter.gVector = CIVector(x: 1, y: 1, z: 0, w: 0)
//        colorMatrixFilter.bVector = CIVector(x: 1, y: 0, z: 1, w: 0)
//
//        guard let filteredImage = colorMatrixFilter.outputImage else {
//            print("Error generating filteredImage")
//            return CIImage()
//        }
//
//        return filteredImage
        
        let colorClampFilter = CIFilter.colorClamp()
        colorClampFilter.inputImage = image
        colorClampFilter.minComponents = CIVector(x: 0, y: 0, z: 0, w: 0)
        colorClampFilter.maxComponents = CIVector(x: 1, y: 0.3, z: 0.3, w: 1)

        guard let colorClampedImage = colorClampFilter.outputImage else {
            print("Error generating colorClampedImage")
            return CIImage()
        }

        return colorClampedImage
    }
    
    private func applyBloomFilter(to image: CIImage) -> CIImage {
        let bloomFilter = CIFilter.bloom()
        bloomFilter.inputImage = image
        bloomFilter.intensity = 0.8
        
        guard let bloomedImage = bloomFilter.outputImage else {
            print("Error generating bloomedImage")
            return CIImage()
        }
        
        return bloomedImage
    }
    
    private func getNoiseImage() -> CIImage {
        let noiseFilter = CIFilter.randomGenerator()
        guard let noiseImage = noiseFilter.outputImage else {
            print("Error generating noiseImage")
            return CIImage()
        }
        
        return noiseImage
    }
}
