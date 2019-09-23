//
//  ContentView.swift
//  ObjectDetector
//
//  Created by Pradnya Nikam on 18/09/19.
//  Copyright © 2019 prad. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var imageData: ImageData
  @State var showImagePicker: Bool = false
  @State var image: UIImage? = nil
  

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
          if (imageData.objectDetectionResult != "") {
            Text(imageData.objectDetectionResult)
          } else {
            Text("Processing...")
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
//      ContentView(showImagePicker: false, imageData: ImageData())
      ContentView()
    }
}
#endif
