//
//  ImageProcessor.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 18/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import Foundation
import UIKit

struct ImageProcessor {
  var imageData: ImageData
  func processImage(image: UIImage) {
//    Dispatch.
    processingComplete()
  }
  func processingComplete() {
    imageData.objectDetectionResult = "Processing Completed. \n 100% Unknown"
  }
}
