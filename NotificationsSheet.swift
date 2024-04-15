//
//  NotificationsSheet.swift
//  WinningYear
//
//  Created by Barbara on 13/04/2024.
//

import SwiftUI

struct NotificationsSheet: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Image("notimage")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                VStack (spacing: 75) {
                    VStack (spacing: 24){
                        Text("Build a consistent habit")
                            .font(.system(size: 30).weight(.bold))
                            .kerning(0.5)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 280)
                            .padding(.horizontal)
                            .padding(.top)
                        Text("Allow notifications to remind you when to reflect so you can build a consistent habit of journaling")
                            .font(.system(size: 14))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 340)
                            .lineLimit(nil)
                            .lineSpacing(3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    VStack (spacing: 24){
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Continue")
                                .padding()
                                .foregroundColor(.white)
                                .font(.system(size: 16).weight(.bold))
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(12)
                        })
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Not Now")
                                .foregroundColor(.blue)
                                .font(.system(size: 16).weight(.medium))
                                .cornerRadius(12)
                        })
                    }
                    .padding()
                }
            }
            .background(.white)
        }
    }
}


#Preview {
    NotificationsSheet()
}
