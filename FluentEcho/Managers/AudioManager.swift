//
//  AudioManager.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 16/04/26.
//

import Foundation
import AVFoundation
import Combine

class AudioManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    
    @Published var isPlaying: Bool = false
    
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
            player?.volume = 10
            player?.delegate = self
            isPlaying = true
            player?.play()
            
            print(isPlaying ? "TRUE PLAY" : "FALSE PLAY")
            
        } catch {
            print("Failed to playback audio:", error)
        }
    }
    
    func stopPlayback() {
        player?.stop()
        isPlaying = false
        print("PLAY STOP")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // When the audio play finishes, set isPlaying to false
        isPlaying = false
        print(isPlaying ? "TRUE PLAY DELEGATE" : "FALSE PLAY DELEGATE")
    }
}
