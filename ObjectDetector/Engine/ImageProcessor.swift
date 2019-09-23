//
//  ImageProcessor.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 18/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import Foundation
import UIKit

class ImageProcessor : ObservableObject {
//  var imageData: ImageData
  @Published var objectDetectionResult = ""
  func processImage(image: UIImage) {
    print("process image called \(image.debugDescription)")
    processingComplete()
  }
  func processingComplete() {
    print("process image complete")
    self.objectDetectionResult = "Processing Completed. \n 100% Unknown"
  }
}
