//
//  Emoji.swift
//  EmoteYote
//
//  Created by Kevin Chan on 2017-12-02.
//  Copyright © 2017 Anthony Smith. All rights reserved.
//

import Foundation
import CoreGraphics

class Emoji {
    var emojiValue: String?
    var skinTone: String?
    var xPos: Float?
    var yPos: Float?
    var zPos: Float?
    
    init() {
        // perform some initialization here
        self.emojiValue = String.randomEmoji
        self.skinTone = "base"
        self.xPos = 0.0
        self.yPos = 0.0
        self.zPos = -0.2
        
    }
    
    
}
