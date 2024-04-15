//
//  InputField.swift
//  WinningYear
//
//  Created by Barbara on 14/03/2024.
//

import SwiftUI

struct InputField: View {
    
    @State var textFieldText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var text: String = ""
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
                    ZStack(alignment: .topTrailing) {
                        Image("kobe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .cornerRadius(3)
                            .padding(.horizontal) // Adjust horizontal padding as needed
                            .padding(.vertical)
                        
                        Button(action: {
                            // Add action for the button here
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                                .padding(5) // Adjust padding around the button icon as needed
                        }
                    }
                }
            }
        }
        

//                          VStack {
//                   TextEditor(text: $text)
//                       .frame(height: 200) // Adjust height as needed
//                   
//                   Button(action: {
//                       // Code to add image
//                       // This can be achieved through UIImagePickerController or other methods
//                       // After selecting the image, you can set the image property
//                       // Example:
//                       // self.image = selectedImage
//                   }) {
//                       Image(systemName: "camera")
//                           .resizable()
//                           .frame(width: 25, height: 25)
//                   }
//                   .padding()
//                   
//                   // Display the selected image
//                   if let image = image {
//                       Image(uiImage: image)
//                           .resizable()
//                           .aspectRatio(contentMode: .fit)
//                           .frame(height: 100) // Adjust height as needed
//                   }
//                   
//                   Spacer()
//               }
//               .padding()
//           }
//       }
//
////        CustomTextField(placeholder: "Type something...", text: $textFieldText)
////            .focused($isTextFieldFocused)
////            .font(.title3)
////            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
////            .onAppear {
//////                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                    
////                    isTextFieldFocused = true
//////                        }
////            }
////    }
////    
////
////    struct CustomTextField: View {
////        var placeholder: String
////        @Binding var text: String
////        
////        var body: some View {
////            ZStack(alignment: .leading) {
////                if text.isEmpty {
////                    Text(placeholder)
////                        .foregroundColor(Color("titleGrey")) // Change the placeholder color here
////                        .padding(.leading, 8) // Adjust as needed
////                }
////                TextField("", text: $text)
////                    .foregroundColor(.white)
////                    .padding(.leading, 8) // Adjust as needed
////            }
////        }
////    }

#Preview {
    InputField()
}
