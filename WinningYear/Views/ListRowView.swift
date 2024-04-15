//
//  ListRowView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import UIKit
import SwiftUI
//import SwiftAnthropic

struct ListRowView: View {
    
    let item: ItemModel
    @State private var showEnlargedImage = false
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var tappedImageIndex: Int? = nil

    @State private var recommendationCards: [String] = []
    @State private var recommendation: String = ""
    @State private var showRecommendation: Bool = false
    let sampleRecommendation = "Congratulations on having your photo featured in the Dr Martens store! To celebrate this achievement, you could:\n\n1. Share the news on social media and tag Dr Martens to express your appreciation.\n\n2. Treat yourself to a new pair of Dr Martens shoes to commemorate the occasion.\n\n3. Frame the photo and display it proudly in your home or workspace.\n\n4. Organize a small gathering with friends and family to celebrate your success.\n\n5. Write a blog post or article about your experience and the story behind the photo.\n\nRemember to take a moment to reflect on your hard work and enjoy this well-deserved recognition!"


    let apiKey = "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"
//    let service: AnthropicService
    
    init(item: ItemModel) {
        self.item = item
//        self.service = AnthropicServiceFactory.service(apiKey: apiKey)
    }
    
    var body: some View {
    
        
        //        HStack {
        //            Image("star")
        //                .font(.system(size: 24))
        // ITEM ONLY
        //                    HStack {
        //                        Text(item.title)
        //                            .font(.subheadline)
        //                            .padding(.vertical, 8)
        //                            .foregroundColor(.black)
        //                        Spacer()
        //                    }
        //                }
        
        //List with Image
        HStack (spacing: 16) {
            if let imageData = item.imageData, !imageData.isEmpty {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 75, maxHeight: 75)
                    .cornerRadius(6)
                    .onTapGesture {
                        self.showEnlargedImage.toggle()
                    }
                    .fullScreenCover(isPresented: $showEnlargedImage) {
                        EnlargedImageView(isPresented: $showEnlargedImage, items: listViewModel.items, clickedItem: item)
                    }
            }
            // ITEM WITH DATE ON BOTTOM Day, Date, Month
            VStack (alignment: .leading, spacing: 0) {
                Text(item.title)
                    .font(.subheadline)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)

                
                HStack {
                    HStack {
                        Text(formatDate(item.timestamp)) // Use the formatted date here
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .padding(.bottom, 5)
                    }
                }
            }
            Spacer()
            // In the button action
//            Button(action: {
//                generateRecommendation(for: item.title)
//                showRecommendation = true
//            }, label: {
//                Image(systemName: "sparkle")
//                    .font(.system(size: 24))
//                    .foregroundColor(.blue)
//            })

            // Sheet to display the recommendation
            .sheet(isPresented: $showRecommendation) {
                VStack {
                    Text("Recommendations")
                        .font(.title)
                        .padding()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(0..<recommendationCards.count, id: \.self) { index in
                                RecommendationCardView(
                                    recomTitle: "Recommendation \(index + 1)",
                                    recommendation: recommendationCards[index]
                                )
                            }
                        }
                        .padding()
                    }
                    
                    Button("Close") {
                        showRecommendation = false
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.mainColour)
                }
                .padding(24)
                .background(.black)
            }

        }
        .cornerRadius(10)

        
    }
    // Function to format the date
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM" // Customize the date format as needed
        return dateFormatter.string(from: date)
    }
//    func generateRecommendation(for title: String) {
//        Task {
//            let prompt = "\n\nHuman: Given the title '\(title)', provide a recommendation on how to celebrate this win.\n\nAssistant:"
//            let maxTokens = 100
////            let parameters = TextCompletionParameter(model: .claude2, prompt: prompt, maxTokensToSample: maxTokens)
//
//            do {
////                       let textCompletion = try await service.createTextCompletion(parameters)
////                       let fullRecommendation = textCompletion.completion
//
//                       // Split the full recommendation into separate cards
//                       recommendationCards = fullRecommendation.components(separatedBy: "\n\n")
//                   } catch {
//                       print("Error generating recommendation: \(error)")
//                   }
//        }
//    }
//    func generateRecommendation(for title: String) {
//
//        // Sample recommendation
//        let sampleRecommendation = "Congratulations on having your photo featured in the Dr Martens store! To celebrate this achievement, you could:\n\n1. Share the news on social media and tag Dr Martens to express your appreciation.\n\n2. Treat yourself to a new pair of Dr Martens shoes to commemorate the occasion.\n\n3. Frame the photo and display it proudly in your home or workspace.\n\n4. Organize a small gathering with friends and family to celebrate your success.\n\n5. Write a blog post or article about your experience and the story behind the photo.\n\nRemember to take a moment to reflect on your hard work and enjoy this well-deserved recognition!"
//
//        recommendation = sampleRecommendation
//        showRecommendation = true
//    }


    
    // CODE FOR TIME
    //Text(formatTime(item.timestamp)) // Use the formatted time here
    //    .font(.system(size: 10))
    //                            .fontWeight(.bold)
    //    .foregroundColor(.gray)
    //
    //        // Function to format the time
    //        private func formatTime(_ date: Date) -> String {
    //            let timeFormatter = DateFormatter()
    //            timeFormatter.dateFormat = "HH:mm" // Customize the time format as needed
    //            return timeFormatter.string(from: date)
    //        }
    
    
    
    
    // ITEM WITH DATE ON SIDE - wednesday 21 february
    //        HStack {
    //            Text(item.title)
    //            Spacer()
    //            DateInfoView(date: item.timestamp)
    //                .padding(.vertical)
    //            //            Text((formattedDate(item.timestamp)))
    //            //                .font(.system(size: 12, weight: .regular))
    //            //                .foregroundColor(.gray)
    //
    //
    //            //        .padding(.trailing, -20) // Apply padding to the trailing side only
    //        }
    //    }
    //            struct DateInfoView: View {
    //                let date: Date
    //
    //                var body: some View {
    //                    VStack {
    //                        Text(dayOfWeek(date))
    //                            .font(.system(size: 10))
    //                            .foregroundColor(.gray)
    //                            .opacity(0.5)
    //
    //                        Text(dayOfMonth(date))
    //                            .font(.system(size: 24))
    //                            .foregroundColor(.gray)
    //
    //                        Text(month(date))
    //                            .font(.system(size: 10))
    //                            .foregroundColor(.gray)
    //                            .opacity(0.5)
    //                    }
    //
    //                }
    //
    //                private func dayOfWeek(_ date: Date) -> String {
    //                    return formatDate(date, format: "EEEE")
    //                }
    //
    //                private func dayOfMonth(_ date: Date) -> String {
    //                    return formatDate(date, format: "dd")
    //                }
    //
    //                private func month(_ date: Date) -> String {
    //                    return formatDate(date, format: "MMMM")
    //                }
    //
    //                private func formatDate(_ date: Date, format: String) -> String {
    //                    let dateFormatter = DateFormatter()
    //                    dateFormatter.dateFormat = format
    //                    return dateFormatter.string(from: date)
    //                }
    //            }
    //        }
    
    //ITEM WITH DATE ON SIDE DD/MM/YY
    //        HStack {
    //            Text(item.title)
    //                .font(.subheadline)
    //                .padding(.vertical, 8)
    //                .foregroundColor(.black)
    //            Spacer()
    //            Text((formattedDate(item.timestamp)))
    //                .font(.system(size: 10, weight: .regular))
    //                .foregroundColor(.gray)
    //            //        .padding(.trailing, -20) // Apply padding to the trailing side only
    //        }
    //
    //    }
    //        private func formatDate(_ date: Date, format: String) -> String {
    //            let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = format
    //            return dateFormatter.string(from: date)
    //        }
    //
    //        private func formattedDate(_ date: Date) -> String {
    //            let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = "dd/MM/yyyy"
    //            return dateFormatter.string(from: date)
    //        }
    //
    
    struct RecommendationCardView: View {
        let recomTitle: String
        let recommendation: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                Text(recomTitle)//recomTitle
                    .colorInvert()
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                VStack(alignment: .leading, spacing: 25) {
                    Text(recommendation)//recommendation
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
    
    struct EnlargedImageView: View {
        @Binding var isPresented: Bool
        @State private var currentIndex: Int
        @State private var dragOffset: CGSize = .zero
        @Environment(\.presentationMode) var presentationMode
        let items: [ItemModel]
        
        init(isPresented: Binding<Bool>, items: [ItemModel], clickedItem: ItemModel) {
            self._isPresented = isPresented
            // Filter out items without an image
            self.items = items.filter { $0.imageData != nil && !$0.imageData!.isEmpty }
            // Find the index of the clicked item within the filtered items
            self._currentIndex = State(initialValue: self.items.firstIndex(where: { $0.id == clickedItem.id }) ?? 0)
        }
        
        var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image(uiImage: UIImage(data: items[currentIndex].imageData ?? Data()) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                // Dismiss the keyboard when dragged
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                                // Update drag offset
                                dragOffset = gesture.translation
                            }
                            .onEnded { gesture in
                                // Dismiss the sheet when dragged down
                                if dragOffset.height > 100 {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                dragOffset = .zero
                            }
                    )
                    .onTapGesture {
                        // Cycle to the next image
                        currentIndex = (currentIndex + 1) % items.count
                    }
                
                VStack {
                    Spacer()
                    Text(items[currentIndex].title)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .topLeading)
                        .padding(.horizontal)
                    Text(formatDate(items[currentIndex].timestamp))
                        .font(.subheadline)
                        .foregroundColor(Color("border"))
                        .opacity(0.8)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }
        }
        
        private func formatDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, dd MMM" // Customize the date format as needed
            return dateFormatter.string(from: date)
        }
    }


}
    




struct ListRowView_Previews: PreviewProvider {
    static let sampleImageData: Data = {
        guard let image = UIImage(named: "kobe") else {
            return Data()
        }
        
        guard let imageData = image.pngData() else {
            return Data()
        }
        
        return imageData
    }()

    static var item1 = ItemModel(id: "1", title: "First item!", timestamp: Date(), imageData: sampleImageData)

    static var previews: some View {
        ListRowView(item: item1)
    }
}

//#Preview {
//    ListRowView(item: ItemModel(id: "1", title: "First item!", timestamp: Date()))
//}
