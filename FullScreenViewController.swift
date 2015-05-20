//
//  FullScreenViewController.swift
//  Streamy
//
//  Created by Nick Jones on 20/05/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {

    var timerHandler = TimerHandler()
    var receivedStream: Stream!
    
    var newStream: Stream!
    
    @IBOutlet var fullScreenImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newStream = Stream()
        newStream.streamPath = receivedStream.streamPath
        
        newStream.getVideoStream()
        
        timerHandler.functionAfterInteval(0.01, classOfFunction: self, functionToRun: "updateImage")
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        if (self.isMovingFromParentViewController()) {
            newStream.videoDataTask.cancel()
        }
    }
    
    func updateImage () {
        fullScreenImage.image = newStream.streamImageViewer.image
    }


}
