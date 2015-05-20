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
    
    var selectedStream: Int!
    var streamArray: [Stream]!
    var firstStream = Stream()
    var secondStream = Stream()
    var thirdStream = Stream()
    var fourthStream = Stream()
    var fifthStream = Stream()
    
//    var tapRecogniser: UITapGestureRecognizer!
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func viewDidLoad() {
        
//        firstWebViewer.addGestureRecognizer(tapRecogniser)
        
        
        firstStream.streamPath = "http://213.221.150.136/mjpg/video.mjpg"
        firstStream.streamName = "Switzerland"
        secondStream.streamPath = "http://plazacam.studentaffairs.duke.edu/mjpg/video.mjpg"
        secondStream.streamName = "Duke University"
        thirdStream.streamPath = "http://trackfield.webcam.oregonstate.edu/mjpg/video.mjpg"
        thirdStream.streamName = "Oregon State"
        fourthStream.streamPath = "http://128.8.230.14/mjpg/video.mjpg"
        fourthStream.streamName = "Maryland food halls"
        
        fifthStream.streamPath = "http://129.186.176.245/mjpg/video.mjpg"
        fifthStream.streamName = "Iowa State Green"
        
        streamArray = [firstStream, secondStream, thirdStream, fourthStream, fifthStream]
    
        for stream in streamArray {
            stream.getVideoStream()
        }
        var updateTimer = timerHandler.functionAfterInteval(0.01, classOfFunction: self, functionToRun: "updateImage")
        var probeConnectionTimer = timerHandler.functionAfterInteval(1, classOfFunction: self, functionToRun: "connectionStateCheck")
    }
    
    func updateImage () {
        self.collectionView?.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loadFullScreen" {
            var fullScreenViewController = segue.destinationViewController as! FullScreenViewController
            let streamToSend = streamArray[selectedStream]
            fullScreenViewController.receivedStream = streamToSend
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1}
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamArray.count}
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let streamCell = collectionView.dequeueReusableCellWithReuseIdentifier("streamViewerCell", forIndexPath: indexPath) as! StreamViewerCell
        
        
//        var tapRecogniser = UITapGestureRecognizer(target: self, action: "runSegue")
//        streamCell.addGestureRecognizer(tapRecogniser)
        

        streamCell.streamImageView.image = streamArray[indexPath.item].streamImageViewer.image
        streamCell.streamNameLabel.text = streamArray[indexPath.item].streamName
        
        return streamCell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedStream = indexPath.item
        performSegueWithIdentifier("loadFullScreen", sender: self)
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

