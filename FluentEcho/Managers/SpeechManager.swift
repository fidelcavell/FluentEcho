//
//  SpeechManager.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import Foundation
import AVFoundation
import Combine

// Still using 'Combine' -> Prev method version -> need to update to latest(?)
class SpeechManager: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    
    //@Published var isSpeaking: Bool = false
    
    func speak(targetedText: String) {
        let utterance = AVSpeechUtterance(string: targetedText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        synthesizer.speak(utterance)
        //isSpeaking = true
    }
    
    // Should this func stop() deleted?
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        //isSpeaking = false
    }
}
