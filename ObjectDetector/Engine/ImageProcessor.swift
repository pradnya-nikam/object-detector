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
  @Published var objectDetectionResult = ""
  func processImage(image: UIImage) {
    print("Process image called \(image.debugDescription)")
    processingComplete()
  }

  func processingComplete() {
    print("Process image complete")
    self.objectDetectionResult = "Processing Completed. \n 100% Unknown"
  }
}
