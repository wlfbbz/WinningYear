//
//  AddView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//
//
//  AddView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import SwiftUI
import ConfettiSwiftUI
import AVFoundation
import UIKit

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @AppStorage("userName") var userName: String = ""
    @State private var dragOffset: CGSize = .zero
    @State private var showingCongratulations = false
    @State private var counter = 0 // Counter for confetti animation
    @State private var isCameraViewPresented = false
    @State private var capturedImageData: Data?
    @State private var capturedImage: UIImage?
    @State private var showCameraView = false
    @State private var showEnlargedImage = false
    @State private var isPhotoSavedToAlbum = false


    @State private var selectedTabIndex = 0
    let items = ["In what ways have you won today?", "What acts of kindness did you show or receive today?", "What hard thing did you do today?", "List 3 things you're grateful for today", "What steps did you take toward self-care today?", "In what ways are you blessed?"] // Replace with your actual text items
        
    
    // State variable to track whether the keyboard is currently shown
    @State private var isKeyboardShown = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack {
                VStack (alignment: .leading, spacing: 0) {
                    Spacer()
                    Text("Hello \(userName)!") // Use the firstName property
                        .font(.system(size: 24))
                        .foregroundColor(Color("titlePrimary"))
    // Pagination View for different prompts
                    HStack {
                        TabView(selection: $selectedTabIndex) {
                            ForEach(0..<items.count, id: \.self) { index in
                                Text(items[index])
                                    .font(.system(size: 26))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(height: 130)
                        .lineLimit(nil) // Limit the number of lines to 2
                        .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                selectedTabIndex = (selectedTabIndex + 1) % items.count
                            }
                        }) {
                            Image(systemName: "shuffle")
                                .imageScale(.small)
                                .foregroundColor(Color("titleGrey"))
                                .font(.largeTitle)
                        }
                    }

                
                    if let image = capturedImage {
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 300)
                                    .cornerRadius(3)
                                    .padding(.horizontal) // Adjust horizontal padding as needed
                                    .padding(.vertical)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        self.showEnlargedImage.toggle()
                                    }
                                    .sheet(isPresented: $showEnlargedImage) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .edgesIgnoringSafeArea(.all)
                                            .background(Color.black)
                                            .onTapGesture {
                                                self.showEnlargedImage.toggle()
                                            }
                                    }
                                    .frame(minHeight: 100) // Ensure a minimum height for the image
                                
                                Button(action: {
                                    self.capturedImage = nil
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white)
                                        .imageScale(.large)
                                        .padding(5) // Adjust padding around the button icon as needed
                                }
                            }
                        }
                        .padding(.horizontal, -15)
                        .padding(.top, -15)
                    }

//
                    HStack (spacing: 8) {
                        CustomTextField(placeholder: "Type something...", text: $textFieldText)
                            .focused($isTextFieldFocused)
                            .font(.title3)
                            .padding(.bottom)

                        if capturedImage == nil {
                            Button(action: {
                                showCameraView = true
                            }) {
                                Image(systemName: "camera")
                                    .imageScale(.small)
                                    .foregroundColor(.titleGrey)
                                    .font(.largeTitle)
                                    .padding(.bottom)
                            }
                            .fullScreenCover(isPresented: $showCameraView) {
                                CameraView(photoSavedHandler: { photoData in
                                    self.capturedImageData = photoData
                                    if let uiImage = UIImage(data: photoData) {
                                        self.capturedImage = uiImage
                                    }
                                })
                            }
                            .sheet(isPresented: $showEnlargedImage) {
                                ListRowEnlargedImageView(image: capturedImage ?? UIImage(), isPresented: $showEnlargedImage)
                            }
                            .transition(.opacity.combined(with: .scale(scale: 0.8))) // Apply transition modifier
                        }
                        Spacer()
                        Button(action: saveButtonPressed, label: {
                            Text("Add")
                                .foregroundColor(textFieldText.count < 1 ? Color("buttonText") : Color.black)
                                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    //                            .background(textFieldText.count < 1 ? Color(Color("buttonColour")) : Color(Color("buttonDisabled")))
                                .background(textFieldText.isEmpty ? Color("buttonColour") : Color.white)
                                .cornerRadius(19)
                                .padding(.horizontal, -5)
                                .padding(.bottom)
                        })
                        .disabled(textFieldText.isEmpty)
                    }
//                    .padding(.bottom, 25)
                    .animation(.easeInOut(duration: 0.1)) // Apply animation modifier

                    .animation(nil) // Disable animation for this specific HStack
                                    
                    
                    // Hide the default back button and add a Cancel button to dismiss the view
                    .navigationBarBackButtonHidden(true)
                    // Add a Cancel button to dismiss the view
                    .navigationBarItems(trailing:
                                            Button(action: cancelButtonPressed) {
                        Image("cross")
                            .foregroundColor(.gray) // Set the color of the SVG image
                    })
                    
                    .onAppear {
                        isTextFieldFocused = true

//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                            
//                            isTextFieldFocused = true
//                        }
                    }
            
                } //end of Vtsack
                .padding(.horizontal, 20)
                .padding(.top, 100)
                
                if showingCongratulations {
                    // Show Congratulations view with confetti animation
                    Congratulations(image: capturedImage)                        .onAppear {
                            // Increment counter to trigger confetti animation
                            self.counter += 1
                            
//                            // Reset the flag after 3 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//                                showingCongratulations = false
//                            }
                        }
                }
            }//end of Zstack
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    // Dismiss the keyboard when dragged
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    // Update drag offset
                    dragOffset = gesture.translation
                }
                .onEnded { gesture in
                    // Dismiss the sheet when dragged down
                    if dragOffset.height > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                    dragOffset = .zero
                }
        )
        .animation(.spring())
        .confettiCannon(counter: $counter, num: 50, radius: 500.0) // Confetti animation

    }
    
    func saveButtonPressed() {
        print("Captured Image Data: \(capturedImageData)")
        // Add the item and set showingCongratulations to true
        listViewModel.addItem(title: textFieldText, imageData: capturedImageData)
        listViewModel.objectWillChange.send()
        hideKeyboard()
        showingCongratulations = true
        
        // Reset the captured image data
        capturedImageData = nil
        
//        // Use DispatchQueue.main.asyncAfter to dismiss the view and hide the keyboard
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//            presentationMode.wrappedValue.dismiss()
//        }
    }
    
    func hideKeyboard() {
        // Hide the keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func cancelButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color("titleGrey")) // Change the placeholder color here
            }
            TextField("", text: $text)
                .foregroundColor(.white)
        }
    }
}

struct ListRowEnlargedImageView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            self.isPresented = false
                        }
                )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ListViewModel())
    }
}



