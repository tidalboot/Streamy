//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Nick Jones on 18/05/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UICollectionViewController {
    
    var timerHandler = TimerHandler()
    
    var streamArray: [Stream]!
    var firstStream = Stream()
    var secondStream = Stream()
    var thirdStream = Stream()
    
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func viewDidLoad() {
        
        var tapRecogniser = UITapGestureRecognizer(target: self, action: "runSegue")
//        firstWebViewer.addGestureRecognizer(tapRecogniser)
        
        firstStream.streamPath = "http://213.221.150.136/mjpg/video.mjpg"
        secondStream.streamPath = "http://plazacam.studentaffairs.duke.edu/mjpg/video.mjpg"
        thirdStream.streamPath = "http://trackfield.webcam.oregonstate.edu/mjpg/video.mjpg"
        
        streamArray = [firstStream, secondStream, thirdStream]
    
        for stream in streamArray {
            stream.getVideoStream()
        }
        var updateTimer = timerHandler.functionAfterInteval(0.01, classOfFunction: self, functionToRun: "updateImage")
        var probeConnectionTimer = timerHandler.functionAfterInteval(1, classOfFunction: self, functionToRun: "connectionStateCheck")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loadFullScreen" {
            var fullScreenViewController = segue.destinationViewController as! FullScreenViewController
            fullScreenViewController.receivedStream = firstStream
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let streamCell = collectionView.dequeueReusableCellWithReuseIdentifier("streamViewerCell", forIndexPath: indexPath) as! StreamViewerCell
        
        var currentStream: Stream = streamArray[indexPath.item]
        var currentImage = currentStream.streamImageViewer.image
        
        streamCell.streamImageView.image = currentImage
        
        return streamCell
    }
    
    
    func runSegue () {
        performSegueWithIdentifier("loadFullScreen", sender: self)
    }
    
    
    func updateImage () {
        self.collectionView?.reloadData()
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

