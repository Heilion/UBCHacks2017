//
//  Yote.swift
//  EmoteYote
//
//  Created by Kevin Chan on 2017-12-02.
//  Copyright © 2017 Anthony Smith. All rights reserved.
//

import Foundation

class Yote {
    static var maxYoteRadius: Int = 5
    var emojis = [Emoji]()
    
    init() {
        // On initialization, obtain yote from backend, and initialize variables
        generateRandomEmojis()
    }
    
    func updateYote() {
        // Pull a new yote from backend
    }
    
    func generateRandomEmojis() {
        // Generate a random Emojis in place of a pull
        let yoteMax = 10
        for _ in 1...yoteMax {
            let curEmoji = Emoji()
            self.emojis.append(curEmoji)
        }
    }
    
}
