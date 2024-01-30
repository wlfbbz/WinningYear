//
//  AddView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import SwiftUI


struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @AppStorage("userName") var userName: String = "" // Add this line
    @State private var dragOffset: CGSize = .zero
//
//    @State private var selectedTabIndex = 0
//        let items = ["In what ways have you won today?", "What are you grateful for today?", "How did you conquer today's challenges?", "In what ways are you blessed?"] // Replace with your actual text items
        
    
    // State variable to track whether the keyboard is currently shown
    @State private var isKeyboardShown = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: 40) {
                Spacer()
                Text("Hello \(userName)!") // Use the firstName property
                    .font(.system(size: 24))
                    .foregroundColor(Color("titleGrey"))
                Text("In what ways have you won today?")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(height: 70)
                
//                // Pagination View
//                HStack {
//                    TabView(selection: $selectedTabIndex) {
//                                        ForEach(0..<items.count, id: \.self) { index in
//                                            Text(items[index])
////                                                .padding()
//                                                .font(.title)
//                                                .foregroundColor(.white)
//                                                .frame(maxWidth: .infinity, alignment: .leading)
//                                        }
//                                    }
//                                    
//                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//                                    .frame(height: 70)
//                                    .lineLimit(2) // Limit the number of lines to 2
//                                    .fixedSize(horizontal: false, vertical: true) // Allow text to wrap to the second line
////                                    .background(.green)
//                                    .cornerRadius(19)
////                                    .padding(.horizontal) // Adjust the horizontal padding
////                .padding(.horizontal)
//            }
                HStack {
                                    TextField("", text: $textFieldText, prompt: Text("Type something...").foregroundColor(Color("titleGrey")))
                                        .focused($isTextFieldFocused)
                                        .font(.title3) // Use .title for the font
                                        .foregroundColor(.white)
                    
                                        

                    Spacer()
                    Button(action: saveButtonPressed, label: {
                        Text("Add")
                            .foregroundColor(textFieldText.count < 1 ? Color("buttonText") : Color("buttonText"))
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .background(textFieldText.count < 1 ? Color(Color("buttonColour")) : Color(Color("buttonDisabled")))
                            .cornerRadius(19)
                            .padding(.horizontal, -10)
                    })
                    .disabled(textFieldText.isEmpty)
                }
                .padding(.bottom, 25)
                
                
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
                 }
                
            } //end of Vtsack
            .padding(.horizontal, 20)

        }//end of Zstack
        
//        .gesture(DragGesture().onChanged { value in
//            // Hide the keyboard when the user swipes down
//                isKeyboardShown = false
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        })
        
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
    }
    
    func saveButtonPressed() {
        listViewModel.addItem(title: textFieldText)
        presentationMode.wrappedValue.dismiss()
    }
    
    func cancelButtonPressed() {
            presentationMode.wrappedValue.dismiss()
        }
    
}





#Preview {
    NavigationView {
        AddView()
        .environmentObject(ListViewModel())
    }
    }
