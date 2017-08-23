//
//  Recording.swift
//  gabios-framework-tester
//
//  Created by Khan on 29/07/17.
//  Copyright © 2017 com.appyte. All rights reserved.
//

import Foundation


/* 
 
 * This structure is for the already recorded audio.
 * Can be fetched from the user's music album, or he could record and audio, store it .
 
*/


struct Recording: Codable {
    
    let title: String
    let subtitle: String?
    let audioURL: URL
    let locale: Locale?
    
    
    init(title: String, subtitle: String?, audioURL: URL, locale: Locale? ) {
        
        self.title = title
        self.subtitle = subtitle
        self.audioURL = audioURL
        self.locale   = locale
    }
    
}
