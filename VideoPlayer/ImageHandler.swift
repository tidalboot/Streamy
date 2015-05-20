//
//  ImageHandler.swift
//  Streamy
//
//  Created by Nick Jones on 20/05/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import UIKit

class ImageHandler {
    
    func updateStreamViews (viewsToUpdate: [UIImageView], streamsToUse: [Stream]) {
        for (index, stream) in enumerate(streamsToUse) {
            viewsToUpdate[index].image = stream.streamImageViewer.image
        }
    }
    
}