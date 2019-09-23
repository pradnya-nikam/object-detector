//
//  ContentView.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 18/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var imageProcessor: ImageProcessor
  @State private var showImagePicker: Bool = false
  @State private var image: UIImage? = nil
  

    var body: some View {
      VStack {
        //Image
        if (image != nil) {
          GeometryReader { geometry in
            Image(uiImage: self.image!)
              .resizable()
              .scaledToFit()
              .frame(width: geometry.size.width, height: (geometry.size.height/2))
          }
        //Detection Result
          if (imageProcessor.objectDetectionResult.isEmpty) {
            Text("Processing...")
          } else {
            Text(imageProcessor.objectDetectionResult)
          }
        }
        //Button
        Button(action: {
          self.showImagePicker = true
        }) {
          Text("Upload Image")
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
          self.showImagePicker = false
          if(self.image != nil) {
            self.imageData.image = self.image
            ImageProcessor(imageData: self.imageData).processImage(image: self.image!)
          }
        }, content: {
            ImagePicker(isShown: self.$showImagePicker, uiImage: self.$image)
          })
            
      }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().environmentObject(ImageProcessor())
    }
}
#endif
