//
//  Scene.swift
//  EmoteYote
//
//  Created by Anthony Smith on 2017-12-02.
//  Copyright © 2017 Anthony Smith. All rights reserved.
//

import SpriteKit
import ARKit
import Alamofire

extension String{
    static var randomEmoji: String {
        let range = [UInt32](0x1F601...0x1F64F)
        let ascii = range[Int(drand48() * (Double(range.count)))]
        let emoji = UnicodeScalar(ascii)?.description
        return emoji!
    }
}

class Scene: SKScene {
    var displayValue = "😀"
    var curLat: Double?
    var curLong: Double?
    
    override func sceneDidLoad() {
        //scheduleEmojiUpdatePoller()
        
    }
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            // let anchor = ARAnchor(transform: transform)
            let anchor = Anchor(transform: transform)
            anchor.displayValue = self.displayValue
            sceneView.session.add(anchor: anchor)
            AddEmojiToDB(emojiValue: self.displayValue)
        }
    }
    
    func renderEmoji(emoji: Emoji) {
        print("Enter render emoji")
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        print("Got past return")
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            print("In current frame")
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.x = emoji.xPos!
            translation.columns.3.y = emoji.yPos!
            translation.columns.3.z = emoji.zPos!
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            // let anchor = ARAnchor(transform: transform)
            let anchor = Anchor(transform: transform)
            anchor.displayValue = emoji.emojiValue
            sceneView.session.add(anchor: anchor)
        }
    }
    
    func AddEmojiToDB(emojiValue: String) {
        
    }
        
}
