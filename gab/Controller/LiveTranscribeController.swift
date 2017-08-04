//
//  LiveTranscribeController.swift
//  gab
//
//  Created by khan on 04/08/17.
//  Copyright © 2017 com.appyte. All rights reserved.
//

import Foundation
import Speech
import AVFoundation


@objc public protocol LiveDelegate {
    
    func liveText(text : String )
    
}

/* This class helps in live transcribe in real time */

class LiveTranscribeController: NSObject {
    
    let audioEngine = AVAudioEngine()
    
    let speechRecognizer = SFSpeechRecognizer()
    
    let request = SFSpeechAudioBufferRecognitionRequest()
    
    var recognitionTask: SFSpeechRecognitionTask?
    
    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    var liveDelegate: LiveDelegate?
    
    
    private func startLiveTranscribe() throws {
        
        let node = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [unowned self] (buffer, _)  in
                            
                            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request) {
            [unowned self]
            (result, _) in
            if let transcription = result?.bestTranscription {
                
                self.liveDelegate?.liveText(text: transcription.formattedString)
            }
        }
    }
    
    private func stopLiveTranscribe() {
        
        audioEngine.stop()
        
        request.endAudio()
        
        recognitionTask?.cancel()
    }
    
    
    private func authentication() {
        
        SFSpeechRecognizer.requestAuthorization {
            
            [unowned self] (authStatus) in
            
            switch authStatus {
                
            case .authorized:
                
                do {
                try self.startLiveTranscribe()
                } catch let error {
                    print("There was a problem starting recording: \(error.localizedDescription)")
                }
                
            case .denied:
                print("Speech recognition authorization denied")
                
            case .restricted:
                print("Not available on this device")
                
            case .notDetermined:
                print("Not determined")
            }
        }
    }
    
}

extension LiveTranscribeController {
    
 open  func beginLiveTranscribe() {
        
        self.authentication()
    }
}
