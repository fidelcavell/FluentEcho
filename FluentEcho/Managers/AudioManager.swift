//
//  AudioManager.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 16/04/26.
//

import Foundation
import AVFoundation
import Combine

class AudioManager: ObservableObject {
    var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    
    func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        AVAudioApplication.requestRecordPermission { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func startRecording(url: URL) {
        requestMicrophonePermission { granted in
            if !granted {
                print("Microphone permission denied.")
                return
            }
        }
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1
            ]
            recorder = try AVAudioRecorder(url: url, settings: settings)
            recorder?.record()
            
        } catch {
            print("Failed to start recording: ", error)
        }
    }
    
    func stopRecording() {
        recorder?.stop()
        recorder = nil
    }
    
    func playback(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch {
            print("Failed to playback audio:", error)
        }
    }
}
