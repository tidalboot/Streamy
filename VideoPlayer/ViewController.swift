//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Nick Jones on 18/05/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet var firstWebViewer: UIImageView!
    @IBOutlet var secondWebViewer: UIImageView!
    @IBOutlet var thirdWebViewer: UIImageView!
    
    
    var firstStream = StreamHandler()
    var secondStream = StreamHandler()
    var thirdStream = StreamHandler()
    
    var updateTimer: NSTimer!
    var probeConnection: NSTimer!
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func viewDidLoad() {
        firstStream.streamPath = "http://213.221.150.136/mjpg/video.mjpg"
        firstStream.getVideoStream()
        
        secondStream.streamPath = "http://plazacam.studentaffairs.duke.edu/mjpg/video.mjpg"
        secondStream.getVideoStream()
        
        thirdStream.streamPath = "http://trackfield.webcam.oregonstate.edu/mjpg/video.mjpg"
        thirdStream.getVideoStream()
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateImage"), userInfo: nil, repeats: true)
        probeConnection = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("connectionDown"), userInfo: nil, repeats: true)
    }
    
    func updateImage () {
        firstWebViewer.image = firstStream.streamImageViewer.image
        secondWebViewer.image = secondStream.streamImageViewer.image
        thirdWebViewer.image = thirdStream.streamImageViewer.image
    }
    
    func connectionDown () {
        if !firstStream.connectionLive {
            print("Connection dead")
            if firstStream.reconnectAvailable {
                firstStream.getVideoStream()
            }
        }
    }

}

