//
//  VisionClassificationResponseFormatter.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 24/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import Foundation
import Vision
extension VNClassificationObservation {
  func formattedString() -> String {
    return String(
      format:"\(self.identifier): %.2f%%", (self.confidence * 100))
  }
}

