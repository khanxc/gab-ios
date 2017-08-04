//
//  RecordingController.swift
//  gabios-framework-tester
//
//  Created by Khan on 29/07/17.
//  Copyright © 2017 com.appyte. All rights reserved.
//

import Foundation
import AVFoundation
import Speech



@objc public protocol RecordingDelegate {
    
     func  textFromAudio(_ text: String)
    
   @objc optional func unavailable_error(_ text: String)
    
   @objc optional func locale_error(_ text: String)
    
   @objc optional func transcribe_error(_ text: String)
    
    
    
}


/* Code to transcribe already recorded audio file with current locale support */

open class RecordingController: NSObject {
    
    
    public var recordingDelegate: RecordingDelegate?
    
    
    open func transcribeAudio(url: URL, locale: Locale?) {
     
        
        let locale = locale ?? Locale.current
        
        guard let recognizer = SFSpeechRecognizer(locale: locale) else {
            print("Speech recognition not available for specified locale")
            return
        }
        
        if !recognizer.isAvailable {
            print("Speech recognition not currently available")
            return
        }
        
     
        //UI update code goes here //
        
        
        
        let request = SFSpeechURLRecognitionRequest(url: url)
        
        recognizer.recognitionTask(with: request) {
            
            [unowned self] (result, error) in
            
            guard let result = result else {
                
                print("There was an error transcribing the file")
                
                return
            }
            
            if result.isFinal {
               self.recordingDelegate?.textFromAudio(result.bestTranscription.formattedString)
            }
            
        }
    }
}

extension RecordingController {
    
    
    
}

