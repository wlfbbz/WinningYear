//
//  CongratsTest.swift
//  WinningYear
//
//  Created by Barbara on 01/05/2024.
//

import SwiftUI

struct UiTest: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Image
            Image("kobe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
            
            // Caption and timestamp container
            VStack(alignment: .leading, spacing: 8) {
                // Caption
                Text("Your caption goes here")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                // Timestamp
                Text("Posted on")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(.bottom)
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
    }


#Preview {
    UiTest()
}
