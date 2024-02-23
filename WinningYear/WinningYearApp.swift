//
//  WinningYearApp.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//


import SwiftUI

@main
struct WinningYearApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(listViewModel)
                .preferredColorScheme(.light) // Setting the color scheme to light mode

        }
    }
}



