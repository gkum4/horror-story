//
//  StoryProgress.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 23/05/22.
//

import Foundation

class StoryProgress {
    static let shared = StoryProgress()
    var step: Steps = .acceptingTerms
    private var soulsFound = 0
    
    private init() {}
    
    func goToStep(_ newStep: Steps) {
        step = newStep
    }
    
    func soulFound() {
        soulsFound += 1
        
        if soulsFound >= 10 { // TODO: determinar valor
            goToStep(.receivingCall)
        }
    }
    
    func reset() {
        step = .acceptingTerms
        soulsFound = 0
    }
    
    enum Steps {
        case acceptingTerms
        case speechInstructions
        case lookingForSouls
        case receivingCall
        case end
    }
}
