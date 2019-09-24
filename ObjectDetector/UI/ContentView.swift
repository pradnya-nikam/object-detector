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
        //View 1: Image
        if (image != nil) {
          GeometryReader { geometry in
            Image(uiImage: self.image!)
              .resizable()
              .scaledToFit()
              .frame(width: geometry.size.width, height: (geometry.size.height/2))
          }
        //View 2: Detection Result
          if (imageProcessor.objectDetectionResult.isEmpty) {
            Text("Processing...")
          } else {
            Text(imageProcessor.objectDetectionResult)
          }
        }

        //View 3: Button
        Button(action: {
          self.showImagePicker = true
        }) {
          Text("Upload Image")
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
          //This is only called when the image picker is manually dismissed
          self.showImagePicker = false
        }, content: {
          //View 4: Image Picker
          ImagePicker(isShown: self.$showImagePicker, uiImage: self.$image, onDismiss: {
            //Called when the image picker is programmatically dismissed
            //for example when an image is chosen
              self.showImagePicker = false
              if(self.image != nil) {
                self.imageProcessor.processImage(image: self.image!)
              }
            })
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
