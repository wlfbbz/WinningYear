//
//  Congratulations.swift
//  WinningYear
//
//  Created by Barbara on 26/01/2024.
//

import SwiftUI
import EffectsLibrary

struct Congratulations: View {
    
    @State private var isActive = false
    @State private var opacity = 1.0
    
    var config = ConfettiConfig(
        content: [
            .emoji("🙌🏾", 1.0),
            .emoji("🙏🏾", 1.0),
            .emoji("🎉", 1.0),
            .emoji("🥳", 1.0),
            .emoji("🎊", 1.0),
            .emoji("🍾", 1.0),
            .emoji("🥂", 1.0),
            .emoji("💪🏾", 1.0),
            .emoji("👏🏾", 1.0),
            .emoji("👍🏾", 1.0),
            .emoji("🏆", 1.0),
            .emoji("🎈", 1.0),
            .emoji("🥇", 1.0),
            .emoji("🏅", 1.0),
        ],
        backgroundColor: .green.opacity(0.4),
        intensity: .low,
        lifetime: .long,
        initialVelocity: .fast,
        spreadRadius: .medium,
        emitterPosition: .bottom,
        fallDirection: .upwards
    )
    
    var body: some View {
    
        ZStack {

            ConfettiView(config: config)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (spacing: 60) {
                Text("Congratulations!")
                    .font(.largeTitle)
                Text("🎈🎈🎈")
                    .font(.largeTitle)
                Text("You did an amazing job and deserve a 🍪 or a nice green 🍏!")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
            }
            .foregroundColor(.black)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(Animation.easeIn(duration: 3)) {
                self.opacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
#Preview {
    Congratulations()
}
