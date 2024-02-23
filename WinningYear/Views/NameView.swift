//
//  Name Test.swift
//  WinningYear
//
//  Created by Barbara on 28/01/2024.
//

import SwiftUI

struct NameView: View {
    
    @State private var userName: String = ""
    @State private var onboardingComplete: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !onboardingComplete {
                    // Screen 1: Name input screen
                    VStack {
                        Text("Add your Name")
                            .foregroundStyle(.white)
                        
                        VStack (alignment: .leading) {
                            Spacer()
                            Text("What should we call you?")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .frame(height: 50)
                            
                            TextField("", text: $userName, prompt: Text("Enter your name")
                                .foregroundColor(Color("titleGrey")))
                            .padding()
                            .font(.title3) // Use .title for the font
                            .background(Color("buttonColour"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 5)
                            
                            Button(action: {
                                // Save userName to UserDefaults
                                UserDefaults.standard.set(userName, forKey: "userName")
                                
                                // Mark onboarding as completed
                                onboardingComplete = true
                                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                            }) {
                                Text("Save")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(userName.count < 1 ? Color("buttonText") : Color.black)
                                    .background(userName.count < 1 ? Color("buttonDisabled") : Color.white)
                                    .cornerRadius(10)
                            }
                            .disabled(userName.isEmpty)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(Color.black)
                    
                    
                } else {
                    // Screen 2: WelcomeView
                    WelcomeView()
                }
            }
        }
    }
}
                            

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
            .environmentObject(ListViewModel()) // Provide a default ListViewModel
    }
}
