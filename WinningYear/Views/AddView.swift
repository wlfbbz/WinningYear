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


struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @AppStorage("userName") var userName: String = ""
    @State private var dragOffset: CGSize = .zero
    @StateObject var notificationManager = NotificationManager()
    @State private var showingCongratulations = false
    @State private var counter = 0 // Counter for confetti animation

    @State private var selectedTabIndex = 0
    let items = ["In what ways have you won today?", "What acts of kindness did you show or receive today?", "How did you demonstrate resilience or overcome obstacles today?", "List 3 things you're grateful for today", "What steps did you take toward self-care today?"] // Replace with your actual text items
        
    
    // State variable to track whether the keyboard is currently shown
    @State private var isKeyboardShown = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .background(Color(red: 0.68, green: 0.96, blue: 1).opacity(0.35))
//                    .frame(width: 393, height: 327)
//                    .cornerRadius(16)
//                    .offset(x: 0, y: 50)
//                    .blur(radius: 200)
                VStack (alignment: .leading, spacing: 0) {
                    Spacer()
                    Text("Hello \(userName)!") // Use the firstName property
                        .font(.system(size: 24))
                        .foregroundColor(Color("titlePrimary"))
                    //                // Pagination View for different prompts
                    HStack {
                        TabView(selection: $selectedTabIndex) {
                            ForEach(0..<items.count, id: \.self) { index in
                                Text(items[index])
                                //                                                .padding()
//                                    .padding(.trailing, 40)
                                    .font(.system(size: 26))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(height: 150)
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
                                .foregroundColor(Color.titleGrey)
                                .font(.largeTitle)
                        }
                    }
                    HStack (spacing: 8) {
                        TextField("", text: $textFieldText, prompt: Text("Type something...").foregroundColor(Color("titleGrey")))
                            .focused($isTextFieldFocused)
                            .font(.title3) // Use .title for the font
                            .foregroundColor(.white)
                        
                        
                        
                        Spacer()
                        Button(action: saveButtonPressed, label: {
                            Text("Add")
                                .foregroundColor(textFieldText.count < 1 ? Color("buttonText") : Color("buttonText"))
                                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    //                            .background(textFieldText.count < 1 ? Color(Color("buttonColour")) : Color(Color("buttonDisabled")))
                                .background(textFieldText.isEmpty ? Color("buttonColour") : Color("buttonDisabled"))
                                .cornerRadius(19)
                                .padding(.horizontal, -5)
                        })
                        .disabled(textFieldText.isEmpty)
                    }
                    .padding(.bottom, 25)
                    .animation(nil) // Disable animation for this specific HStack
                    
                    //                Spacer()
                    
                    
                    // Hide the default back button and add a Cancel button to dismiss the view
                    .navigationBarBackButtonHidden(true)
                    // Add a Cancel button to dismiss the view
                    .navigationBarItems(trailing:
                                            Button(action: cancelButtonPressed) {
                        Image("cross")
                            .foregroundColor(.gray) // Set the color of the SVG image
                    })
                    
                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            isTextFieldFocused = true
//                        }
                    }
                } //end of Vtsack
                .padding(.horizontal, 20)
                .padding(.top, 100)
                
                if showingCongratulations {
                    // Show Congratulations view with confetti animation
                    Congratulations()
                        .onAppear {
                            // Increment counter to trigger confetti animation
                            self.counter += 1
                            
                            // Reset the flag after 3 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                                showingCongratulations = false
                            }
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
        .onAppear {
                // Schedule notification when the view appears
                notificationManager.scheduleNotifications()
        }
        .animation(.spring())
        .confettiCannon(counter: $counter, num: 50, radius: 500.0) // Confetti animation

    }
    
    func saveButtonPressed() {
        // Add the item and set showingCongratulations to true
        listViewModel.addItem(title: textFieldText)
        hideKeyboard()
        showingCongratulations = true
        
        // Use DispatchQueue.main.asyncAfter to dismiss the view and hide the keyboard
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func hideKeyboard() {
        // Hide the keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func cancelButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
}




struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ListViewModel())
//            .environmentObject(NotificationManager()) // Provide a placeholder NotificationManager
    }
}
