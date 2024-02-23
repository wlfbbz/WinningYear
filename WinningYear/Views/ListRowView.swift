//
//  ListRowView.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
//        HStack {
//            Image("star")
//                .font(.system(size: 24))
            // ITEM ONLY
                    HStack {
                        Text(item.title)
                            .font(.subheadline)
                            .padding(.vertical, 8)
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
            
            // ITEM WITH DATE ON BOTTOM Day, Date, Month
//            VStack (alignment: .leading, spacing: 0) {
//                Text(item.title)
//                    .font(.subheadline)
//                    .padding(.top, 8)
//                    .padding(.bottom, 4)
//                    .foregroundColor(.black)
//                
//                
//                HStack {
//                    HStack {
//                        Text(formatDate(item.timestamp)) // Use the formatted date here
//                            .font(.system(size: 10))
//                            .foregroundColor(.gray)
//                            .opacity(0.5)
//                            .padding(.bottom, 5)
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
                    // Function to format the date
                    private func formatDate(_ date: Date) -> String {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE, dd MMM" // Customize the date format as needed
                        return dateFormatter.string(from: date)
                    }
        
        
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
    }
struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(id: "1", title: "First item!", timestamp: Date())
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
        }
        .previewLayout(.sizeThatFits)
    }
}
//#Preview {
//    ListRowView(item: ItemModel(id: "1", title: "First item!", timestamp: Date()))
//}

