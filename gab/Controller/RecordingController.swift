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


/*
 
 * Code to transcribe already recorded audio file with current locale support
 
*/

open class RecordingController: NSObject {
    
    
    private weak var recordingDelegate: RecordingDelegate?
    
    
    open func transcribeAudio(url: URL, locale: Locale?) throws {
     
        
        let locale = locale ?? Locale.current
        
        guard let recognizer = SFSpeechRecognizer(locale: locale) else {
            
            recordingDelegate?.locale_error!(RecordingError.invalidLocale.description)
            
            return
        }
        
        if !recognizer.isAvailable {
            
            recordingDelegate?.unavailable_error!(RecordingError.recordingUnavailable.description)
            
            return
        }
        
     
        //UI update code goes here //
        
        
        
        let request = SFSpeechURLRecognitionRequest(url: url)
        
        recognizer.recognitionTask(with: request) {
            
            [unowned self] (result, error) in
            
            guard let result = result else {
                
                self.recordingDelegate?.transcribe_error!(RecordingError.transcribeError.description)
                
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


/*
 
 * Error handling enum for Recording Controller
 
*/


private enum RecordingError: Error {
    
    case invalidLocale
    case recordingUnavailable
    case transcribeError
}

extension RecordingError: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
            
        case .invalidLocale: return "The current locale is invalid"
        case .recordingUnavailable: return "Speech recognition not currently available"
        case .transcribeError: return "There was an error transcribing the file"
            
        }
    }
}
