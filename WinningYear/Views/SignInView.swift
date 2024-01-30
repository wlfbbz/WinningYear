//
//  SignInView.swift
//  WinningYear
//
//  Created by Barbara on 22/01/2024.
//

import AuthenticationServices
import SwiftUI

struct SignInView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var listViewModel: ListViewModel // Add this line

    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    private var isSignedIn: Bool {
        !userId.isEmpty
    }

    
    var body: some View {
         if isSignedIn {
             // User is signed in, show content without NavigationView
             NavigationView {
                 ListView()
                     .environmentObject(listViewModel)
             }
         } else {
             // User is not signed in, show sign-in view with NavigationView
             NavigationView {
                 SignInButtonView()
             }
         }
     }
}

struct SignInButtonView: View {
    
    @State private var size = 0.8

    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                                
                VStack {
                    Text("Winning Year")
                        .foregroundStyle(.white)

                    Spacer()

                    Image("oscarnobg")
                        .resizable()
                        .frame(width: 200, height: 300)
                        .scaleEffect(size)
                        .onAppear {
                                withAnimation(.easeIn(duration: 1)) {
                                    self.size = 1
                                                }
                                            }
                                        
                    
                    Spacer()

                }
                
                Spacer()
                SignInWithAppleButton(.continue) { request in
                    
                    request.requestedScopes = [.email, .fullName]
                    
                } onCompletion: { result in
                    
                    switch result {
                    case.success(let auth):
                        
                        switch auth.credential {
                        case let credential as ASAuthorizationAppleIDCredential:
                            
                            // User Id
                            let userId = credential.user
                            
                            // User Info
                            let email = credential.email
                            let firstName = credential.fullName?.givenName
                            let lastName = credential.fullName?.familyName
                            
                            self.email = email ?? ""
                            self.userId = userId
                            self.firstName = firstName ?? ""
                            self.lastName = lastName ?? ""
                            
                        default:
                            break
                        }
                    case.failure(let error):
                        print(error)
                        
                    }
                    
                }
                .signInWithAppleButtonStyle(
                    colorScheme == .dark ? .white : .white
                )
                .frame(height: 50)
                .cornerRadius(100)
                .padding()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    SignInView()
}
