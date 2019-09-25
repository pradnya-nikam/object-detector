//
//  ImageProcessor.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 18/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision

class ImageProcessor : ObservableObject {
  
  @Published var objectDetectionResult = ""
  var objectDetectionModel = MobileNetV2().model
  
  /// - Tag: Step 1: Initialise the model
  private lazy var classificationRequest: VNCoreMLRequest = {
    do {
      let model = try VNCoreMLModel(for: objectDetectionModel)
  
      let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
        self?.processMLResults(fromRequest: request, error: error)
      })
      request.imageCropAndScaleOption = .scaleFit
      return request
    } catch {
      fatalError("Failed to load Vision ML model: \(error)")
    }
  }()
  
  /// - Tag: Step 2: Run the vision request
  func processImage(image: UIImage) {
    print("Process image called \(image.debugDescription)")
    self.objectDetectionResult = "Processing"

    guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from image.") }
    let handler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation.up)
    do {
      try handler.perform([self.classificationRequest])
    } catch {
      /*
       This handler catches general image processing errors.
       */
      print("Failed to perform classification.\n\(error.localizedDescription)")
    }
  }

  /// - Tag: Step 3: Handle the output
  func processMLResults(fromRequest request: VNRequest, error: Error?) {
    guard let results = request.results else {
      print("Unable to classify image.\n\(error!.localizedDescription)")
      return
    }
    
    let output = results as [Any]
    if output.isEmpty {
      print("Nothing recognized.")
    } else {
      if let objectDetectionArray =  output as? [VNClassificationObservation] {
        print("First observation :\n \(objectDetectionArray.first!)")
        processingComplete(objectDetectionArray: objectDetectionArray)
      }
    }
  }

func processingComplete(objectDetectionArray: [VNClassificationObservation]) {
    print("Processing image complete")
    var objectDetectionResult = ""
    if let firstDetection = objectDetectionArray.first {
      objectDetectionResult.append(firstDetection.formattedString())
    }
    if objectDetectionArray.count > 1 {
      let secondDetection = objectDetectionArray[1]
      objectDetectionResult.append("\n" + secondDetection.formattedString())
    }
    self.objectDetectionResult = objectDetectionResult
  }
}
