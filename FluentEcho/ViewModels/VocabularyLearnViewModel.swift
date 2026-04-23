//
//  VocabularyLearnViewModel.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 18/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
class VocabularyLearnViewModel {
    private var context: ModelContext
    private var audioManager = AudioManager()
    
    init(context: ModelContext) {
        self.context = context
        fetchUser()
    }
    
    var user: User?
    var recordedAudioURL: URL? = nil
    
    // Used as a state to indicate that user are still recording their voice or not (by holding recording button)
    var isRecording: Bool = false
    
    // Used as indicator of permission granted to show alert or not
    var isPermissionGranted = true
    
    // Used to show preview after user just record their practice's voice
    var hasPreview: Bool {
        recordedAudioURL != nil && !isRecording
    }
    
    func fetchUser() {
        let descriptor = FetchDescriptor<User>()
        
        do {
            let fetchedUser = try context.fetch(descriptor)
            self.user = fetchedUser.first
            print("FETCH USER is performed!")
            
        } catch {
            print("Failed to fetch user: ", error)
        }
    }
    
    func updateLearnedStatus(byId id: UUID) {
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate {
                $0.id == id
            }
        )
        
        do {
            guard let selectedVocabulary = try context.fetch(descriptor).first else {
                return
            }
            
            if let existingUser = user {
                existingUser.currentLearnedVocabulary += selectedVocabulary.isLearned ? -1 : 1
                selectedVocabulary.isLearned = !selectedVocabulary.isLearned
                try context.save()
                
            } else {
                print("ERROR")
            }
            
        } catch {
            print("Failed to update Vocabulary learning status: ", error)
        }
    }
    
    // Define the path where got used to store the recorded audio files (temporary storage)
    // Note: Run well if kill in background and relaunch the application but audio files will disappear if trying to reinstall via xcode
    func createNewRecordingURL() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        
        let fileName = "\(formatter.string(from: Date()))-\(UUID().uuidString).m4a"
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        recordedAudioURL = documentsPath.appendingPathComponent(fileName)
    }
    
    func startRecording() {
        audioManager.requestMicrophonePermission { granted in
            DispatchQueue.main.async {
                self.recordedAudioURL = nil
                
                if granted {
                    self.createNewRecordingURL()
                    self.isRecording = true
                    self.isPermissionGranted = true
                    
                    guard let recordedURL = self.recordedAudioURL else { return }
                    
                    print("---------")
                    print(recordedURL)
                    print("---------")
                    
                    self.audioManager.startRecording(url: recordedURL)
                    
                    print("Microphone permission granted! [VIEWMODEL]")
                    
                } else {
                    self.isPermissionGranted = false
                    print("Microphone permission not granted! [VIEWMODEL]")
                }
            }
        }
    }
    
    func playRecording() {
        guard let url = recordedAudioURL else { return }
        audioManager.playback(url: url)
    }
    
    func stopRecording() {
        isRecording = false
        audioManager.stopRecording()
    }
    
    func saveRecordingPractice(targetedIndex: Int, targetedVocabulary: Vocabulary) {
        guard let url = recordedAudioURL else { return }
        
        let newRecordingPractice = LearnHistory(
            date: Date(),
            practiceSentenceIndex: targetedIndex,
            recordedAudio: url.absoluteString,
            vocabulary: targetedVocabulary
        )
        targetedVocabulary.learnHistory.append(newRecordingPractice)
        context.insert(newRecordingPractice)
        
        do {
            try context.save()
            print("SAVE LEARN HISTORY is performed!")
            
        } catch {
            print("Failed to save learn history: ", error)
        }
    }
}
