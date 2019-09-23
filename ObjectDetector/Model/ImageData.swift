//
//  ImageData.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 19/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import Foundation
import UIKit

class ImageData : ObservableObject {
  @Published var objectDetectionResult = ""
  @Published var image: UIImage? = nil
}
