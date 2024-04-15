//
//  RecommendationsCard.swift
//  WinningYear
//
//  Created by Barbara on 08/04/2024.
//

import SwiftUI

struct RecommendationsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("Share the news")
                .colorInvert()
                .font(.system(size: 48, weight: .bold, design: .rounded))
            VStack(alignment: .leading, spacing: 25) {
                Text("Share the news on social media and tag Dr Martens to express your appreciation.")
                    .colorInvert()
                    .font(.bold(.headline)())
                    .lineLimit(3)
                    .frame(width: 200)
                    .fixedSize()
                    .padding()
                Image(systemName: "dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 200, alignment: .center)
            }
            .padding(20)
            .background(.blue)
            .cornerRadius(25)
        }
    }
}

#Preview {
    RecommendationsCard()
}
