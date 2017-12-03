//
//  ViewController.swift
//  EmoteYote
//
//  Created by Anthony Smith on 2017-12-02.
//  Copyright © 2017 Anthony Smith. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import SwiftLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    let BASE_URL = "http://6e4c99a4.ngrok.io/api/"
    var timer = Timer()
    var curScene: Scene?
    
    var lastLat: Double! = 0
    var lastLong: Double! = 0
    var lastAlt: Double! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
            
            if let tempScene = scene as? Scene {
                self.curScene = tempScene
            }
        }
        
        // Start local location polling
        self.setUpLocalPolling()
        
        Locator.subscribePosition(accuracy: .room, onUpdate: { (location) -> (Void) in
            self.lastLat = location.coordinate.latitude
            self.lastLong = location.coordinate.longitude
            self.lastAlt = location.altitude
            print("Updating GPS")
        }) { (error, location) -> (Void) in
            print(error)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - Data Polling
    
    func setUpLocalPolling() {
        // Scheduling timer to Call the function "updatePoll" every 5 second, 5 seconds from now.
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: (#selector(ViewController.updateLocalPoll)), userInfo: nil, repeats: true)
        
        // Run polling once manually since the timer won't start until 5 seconds from now

    }
    
    @objc func updateLocalPoll() {
        //print(self.sceneView.session.currentFrame?.camera.transform[3] as! float4)
    
//        guard let lat = self.lastLat, let long = self.lastLong, let alt = self.lastAlt, lat > 0, long > 0, alt > 0 else {
//            return
//        }
        
        let queryUrl = "\(BASE_URL)yotes/?lat=\(self.lastLat)&lng=\(self.lastLong)&height=\(self.lastAlt)"
        Alamofire.request(queryUrl).responseJSON { response in
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let jsonResponse = response.result.value {
                let json = JSON(jsonResponse)
                
                for var i in (0..<json.count) {
                    let yoteId = json[i]["YoteId"]
                    let data = json[i]["data"]
                    let x = json[i]["X"].double
                    let y = json[i]["Y"].double
                    let z = json[i]["Z"].double
                    
                    self.curScene?.renderEmoji()
                }
                
                print("JSON: \(json)") // serialized json response
            }
        }
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        var node: SKNode?
        if let anchor = anchor as? Anchor {
            if let displayValue = anchor.displayValue {
                node = SKLabelNode(text: displayValue)
                node?.name = displayValue
                
            }
        }
        return node;
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
