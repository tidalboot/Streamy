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
    
    var timerHandler = TimerHandler()
    
    @IBOutlet var firstWebViewer: UIImageView!
    @IBOutlet var secondWebViewer: UIImageView!
    @IBOutlet var thirdWebViewer: UIImageView!
    
    var streamArray: [Stream]!
    var streamViewerArray: [UIImageView]!
    var firstStream = Stream()
    var secondStream = Stream()
    var thirdStream = Stream()
    
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func viewDidLoad() {
        firstStream.streamPath = "http://213.221.150.136/mjpg/video.mjpg"
        secondStream.streamPath = "http://plazacam.studentaffairs.duke.edu/mjpg/video.mjpg"
        thirdStream.streamPath = "http://trackfield.webcam.oregonstate.edu/mjpg/video.mjpg"
        
        streamArray = [firstStream, secondStream, thirdStream]
        streamViewerArray = [firstWebViewer, secondWebViewer, thirdWebViewer]
        
        for stream in streamArray {
            stream.getVideoStream()
        }
        
        var updateTimer = timerHandler.functionAfterInteval(0.01, classOfFunction: self, functionToRun: "updateImage")
        var probeConnectionTimer = timerHandler.functionAfterInteval(1, classOfFunction: self, functionToRun: "connectionStateCheck")
    }
    
    func updateImage () {
        for (index, stream) in enumerate(streamArray) {
            streamViewerArray[index].image = stream.streamImageViewer.image
        }
    }
    
    func connectionStateCheck () {
        for stream in streamArray {
            if !stream.connectionLive {
                println("Connection dead")
                if stream.reconnectAvailable {
                    stream.getVideoStream()
                }
            }
        }
    }

}

