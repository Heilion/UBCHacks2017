//
//  Scene.swift
//  EmoteYote
//
//  Created by Anthony Smith on 2017-12-02.
//  Copyright © 2017 Anthony Smith. All rights reserved.
//

import SpriteKit
import ARKit

extension String{
    static var randomEmoji: String {
        let range = [UInt32](0x1F601...0x1F64F)
        let ascii = range[Int(drand48() * (Double(range.count)))]
        let emoji = UnicodeScalar(ascii)?.description
        return emoji!
    }
}

class Scene: SKScene {
    var timer = Timer()
    var displayValue = "😀"
    
    override func sceneDidLoad() {
        scheduleEmojiUpdatePoller()
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
            anchor.displayValue = displayValue
            sceneView.session.add(anchor: anchor)
        }
    }
    
    func scheduleEmojiUpdatePoller() {
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(Scene.updateEmote)), userInfo: nil, repeats: true)
    }
    
    @objc func updateEmote() {
        self.displayValue = String.randomEmoji
    }
}
