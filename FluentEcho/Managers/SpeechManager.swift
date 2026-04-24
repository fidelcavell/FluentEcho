//
//  SpeechManager.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 14/04/26.
//

import Foundation
import AVFoundation
import Combine

class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    // This line of code is warning
    private let synthesizer = AVSpeechSynthesizer()
    
    @Published var isSpeaking: Bool = false
    
    func speak(targetedText: String) {
        let utterance = AVSpeechUtterance(string: targetedText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 2.0
        
        synthesizer.speak(utterance)
        synthesizer.delegate = self
        isSpeaking = true
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // When the speech finishes, set isSpeaking to false
        isSpeaking = false
    }
}
