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
    var fullScreenStream: Stream!
    
    @IBOutlet var fullScreenImage: UIImageView!
    @IBOutlet var fullScreenStreamTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullScreenStream = Stream()
        fullScreenStream.streamPath = receivedStream.streamPath
        fullScreenStream.streamName = receivedStream.streamName
        
        fullScreenStream.getVideoStream()
        
        timerHandler.functionAfterInteval(0.01, classOfFunction: self, functionToRun: "updateImage")
        fullScreenStreamTitle.title = fullScreenStream.streamName
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            self.navigationController?.navigationBarHidden = true
            return
        }
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (self.isMovingFromParentViewController()) {
            fullScreenStream.videoDataTask.cancel()
        }
    }
    
    func updateImage () {
        fullScreenImage.image = fullScreenStream.streamImageViewer.image
    }


}
