//
//  WelcomeView.swift
//  WinningYear
//
//  Created by Barbara on 29/01/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isActive = false
    @AppStorage("userName") private var userName: String = ""
    @State private var offset = CGSize.zero
    @State private var opacity = 1.0

    var body: some View {
        
        ZStack {
                    if isActive {
                        ListView()
                            .transition(.move(edge: .bottom)) // Slide-up transition
                    } else {
                        Color.black.edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Text("Welcome, \(userName)!")
                                .foregroundStyle(.white)
                                .padding()
                    // Add other views or functionality for the main part of your app
                }
                .offset(y: offset.height)
                .onAppear {
                                   // Delay the transition to the ListView
                    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                       withAnimation {
                                           self.isActive = true
                                           self.offset = CGSize(width: 0, height: -UIScreen.main.bounds.height)
                                       }
                                   }
                               }
                           }
                       }
                   }
               }
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(ListViewModel()) // Provide a default ListViewModel
    }
}

