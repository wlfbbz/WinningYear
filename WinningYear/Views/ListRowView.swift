//
//  ListRowView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
//    let index: Int

    init(item: ItemModel/*, index: Int*/) {
        self.item = item
//        self.index = index
    }
    
    
    var body: some View {
        VStack (spacing: 8) {
            HStack {
    //            Text("\(index).") // Display the item number
    //                .font(.subheadline)
    //                .foregroundColor(.black) // You can customize the color
                Text(item.title) // Display the item content
                    .font(.subheadline)
//                    .fontWeight(.bold)
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                Spacer()
//                Text("🏅")
            }
//            .padding(.horizontal)
//            .background(Color.white)
            .cornerRadius(10)

//            HStack {
//                HStack {
////                    Spacer()
//                Text(formatDate(item.timestamp)) // Use the formatted date here
//                            .font(.system(size: 10))
////                            .fontWeight(.bold)
//                            .foregroundColor(.gray)
//                    Spacer()
//                Text(formatTime(item.timestamp)) // Use the formatted time here
//                        .font(.system(size: 10))
////                            .fontWeight(.bold)
//                            .foregroundColor(.gray)
//
////                Spacer()
//
//            }
//            }
//            .padding(.horizontal)

        }
    }
}

// Function to format the date
private func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, dd MMM" // Customize the date format as needed
    return dateFormatter.string(from: date)
}

// Function to format the time
private func formatTime(_ date: Date) -> String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm" // Customize the time format as needed
    return timeFormatter.string(from: date)
}


struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(id: "1", title: "First item!", timestamp: Date())
    
    static var previews: some View {
        Group {
            ListRowView(item: item1/*, index: 1*/)
        }
        .previewLayout(.sizeThatFits)
    }
}
//#Preview {
//    ListRowView(item: ItemModel(id: "1", title: "First item!", timestamp: Date()))
//}

