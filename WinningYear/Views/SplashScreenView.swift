//  WinningYear
//
//  Created by Barbara on 23/01/2024.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.1
    @State private var opacity = 0.5
    @State private var onboardingComplete: Bool = false
    
    var body: some View {
        ZStack {
            if isActive {
                if onboardingComplete {
                    ListView()
                        .transition(.opacity) // Crossfade transition
                } else {
                    NameView()
                        .transition(.opacity) // Crossfade transition
                }
            } else {
                Color.checkmark.edgesIgnoringSafeArea(.all)
                    .opacity(1)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 4.5)) {
                            self.opacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                    .onAppear {
                        // Check if onboarding is already completed
                        if UserDefaults.standard.bool(forKey: "onboardingCompleted") {
                            self.onboardingComplete = true
                        }
                    }
                
                VStack {
                    Spacer()
                    ZStack {
                        Image(systemName: "circle.fill")
                            .shadow(radius: 100)
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                            .scaleEffect(size)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    withAnimation(.easeIn(duration: 4)) {
                                        self.size = 46.5
                                    }
                                    withAnimation(.easeOut(duration: 4)) {
                                        self.size = 0.1
                                    }
                                }
                            }
                        Text("Take a deep breath")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .kerning(1.0)
                    }
                    Spacer()
                    Text("Winning Year")
                        .foregroundColor(.black)
                }
            }
        }
    }
}



#Preview {
    SplashScreenView()
}
