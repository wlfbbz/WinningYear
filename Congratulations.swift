//  Congratulations.swift
//  WinningYear
//
//  Created by Barbara on 26/01/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct Congratulations: View {
    @State private var size = 0.7
    @State private var counter = 0
    var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("🏆")
                        .font(.system(size: 80))
                        .padding(.bottom, 10)
                    
//                    Image("oscarnobg")
//                        .resizable()
//                        .frame(width: 200, height: 300)
//                        .scaleEffect(size)
//                        .onAppear {
//                                withAnimation(.easeIn(duration: 1)) {
//                                    self.size = 0.78
//                                                }
//                                            }
                    Text("Congratulations!")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    Text("You did an amazing job and deserve a 🍪 or a nice green 🍏")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .lineSpacing(10.0)
                        .font(.system(size: 16))
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 300, maxHeight: 200)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .padding(.vertical)
                    }
                    
                    VStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Continue")
                                .font(.system(size: 16).weight(.bold))
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(20)
                                .padding(.horizontal, 24)
                                .padding(.top, 20)
                        })
                    }
                    Spacer()

                } // end of vstack
 
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.counter += 1 // Increment counter to trigger confetti animation
            }
        }

        .confettiCannon(counter: $counter, num: 50, radius: 500.0)
    }
}

struct Congratulations_Previews: PreviewProvider {
    static var previews: some View {
        Congratulations()
    }
}
