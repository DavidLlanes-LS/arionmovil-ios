//
//  ProfileImage.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 06/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import SwiftUI

struct ProfileImage: View {
    @State private var image: Image? = Image("profile")
      @State private var shouldPresentImagePicker = false
      @State private var shouldPresentActionScheet = false
      @State private var shouldPresentCamera = false
    var body: some View {
        GeometryReader {reader in
            ZStack(alignment:.center){
            image!
            .resizable()
            .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                Button(action:{
                    shouldPresentActionScheet = true
                }){
                    ZStack{
                        Image("edit").renderingMode(.template).resizable().scaledToFit().frame(width:reader.size.height*0.08, height:reader.size.height*0.08)
                    }
                    .frame(width:reader.size.height*0.15, height:reader.size.height*0.15).foregroundColor(Color.white).background(Color("secondary-background"))
                        .clipShape(Circle())
                }.offset(x:reader.size.width*0.26,y:-reader.size.height*0.22)
                
            }.frame(width: reader.size.width, height: reader.size.height, alignment: .center).sheet(isPresented: $shouldPresentImagePicker) {
                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
        }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("S"+String("elecciona una imagen").lowercased()), buttons: [ActionSheet.Button.default(Text("C"+String("ámara").lowercased()), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("G"+String("alería").lowercased()), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
    }
        }
    }


struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage()
    }
}
