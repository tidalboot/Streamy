//
//  StreamHandler.swift
//  Streamy
//
//  Created by Nick Jones on 19/05/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import UIKit

class Stream: UIView,  NSURLSessionDataDelegate {

    let dataMarker: NSData = NSData(bytes: [0xFF, 0xD9] as [UInt8], length: 2)
    var streamPath: String!
    var streamName: String!
    var recievedData: NSMutableData = NSMutableData()
    var videoDataTask: NSURLSessionDataTask!
    var streamImageViewer = UIImageView()
    var connectionLive: Bool = true
    
    var reconnectAvailable: Bool = false

    
    func getVideoStream () {
        var streamURL: NSURL = NSURL(string: streamPath)!
        let videoSession = NSURLSession(configuration:  NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        var videoURLRequest = NSURLRequest(URL: streamURL)

        self.videoDataTask = videoSession.dataTaskWithRequest(videoURLRequest)
        self.videoDataTask.resume()
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData: NSData) {
        
        if !connectionLive {
            connectionLive = true
        }
        
        reconnectAvailable = false
        
        self.recievedData.appendData(didReceiveData)
        var rangeOfImageDataWithinRecievedData: NSRange = self.recievedData.rangeOfData(self.dataMarker, options: nil, range: NSMakeRange(0, self.recievedData.length))
        var endByteLocation = rangeOfImageDataWithinRecievedData.location + rangeOfImageDataWithinRecievedData.length
        
        if self.recievedData.length >= endByteLocation {
            var imageDate = self.recievedData.subdataWithRange(NSMakeRange(0, endByteLocation))
            var recievedImage = UIImage(data: imageDate)
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.streamImageViewer.image = recievedImage
            })
            
            self.recievedData = NSMutableData(data: self.recievedData.subdataWithRange(NSMakeRange(endByteLocation, self.recievedData.length - endByteLocation)))
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        connectionLive = false
        reconnectAvailable = true
    }

}




