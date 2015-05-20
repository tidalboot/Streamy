//
//  TimerHandler.swift
//  Streamy
//
//  Created by Nick Jones on 20/05/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation

class TimerHandler {
    
    func functionAfterInteval (interval: NSTimeInterval, classOfFunction: AnyObject, functionToRun: String) -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(interval, target: classOfFunction, selector: Selector("\(functionToRun)"), userInfo: nil, repeats: true)
    }
    
}