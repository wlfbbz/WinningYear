//
//  ContributionsCalendar.swift
//  WinningYear
//
//  Created by Barbara on 28/03/2024.
//

import SwiftUI

struct ContributionsCalendar: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var currentDate = Date()
    @ObservedObject var viewModel: ListViewModel
    @State private var selectedItems: [ItemModel] = []
    @State private var showItemDetails = false
    @State private var selectedDate: Date?
    @State private var selectedDateWrapper: DateWrapper?

    // Sample data for testing, replace it with your actual data source
    let items: [ItemModel] = [
        ItemModel(id: "1", title: "First item!", timestamp: Date(), imageData: nil)
        // Add more sample items as needed
    ]
    let weekdays: [String] = ["M","T","W","T","F","S","S"]

    let monthlabel: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 0) {
//                HStack {
//                    Spacer()
//                    Text("Contributions:")
//                        .font(.title3)
//                    HStack {
//                        VStack {
//                            Text("\(viewModel.items.count)")
//                                .font(.system(size: 16))
//                            //                            .padding(8)
//                            //                            .background(.blue.opacity(0.2))
//                                .cornerRadius(8)
//                                .foregroundColor(.gray.opacity(0.5))
//                            //                        Text("You have made")
//                            //                            .font(.system(size: 12))
//                            //                        Text(viewModel.items.count == 1 ? "contribution this year" : "contributions this year")
//                            //                            .font(.system(size: 12))
//                        }
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal)
//                
//                HStack(spacing: 0) {
//                    Text("2024")
//                        .foregroundColor(.gray)
//                        .opacity(0.25)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
//                .padding(.vertical, 8)
                
                //                HStack {
                //                    let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 12)
                //                        Text("2024")
                //                            .foregroundColor(.gray)
                //                            .opacity(0.25)
                ////                            .font(.system(size: 14))
                //
                //                    LazyVGrid(columns: columns, spacing: 8) {
                //                        // Weekday abbreviations row
                //                        ForEach(weekdays, id: \.self) { weekday in
                //                            Text(weekday)
                //                                .font(.caption)
                //                                .foregroundColor(.gray)
                //                        }
                //
                //
                //                    }
                //                                .frame(maxWidth: .infinity)
                //                            }
                //                .padding()
                
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (spacing: 0) {
                        HStack {
                            Spacer()
                            Text("Contributions:")
                                .font(.system(size: 16))
                            HStack {
                                VStack {
                                    Text("\(viewModel.items.count)")
                                        .font(.system(size: 16))
                                    //                            .padding(8)
                                    //                            .background(.blue.opacity(0.2))
                                        .cornerRadius(8)
                                        .foregroundColor(.gray.opacity(0.5))
                                    //                        Text("You have made")
                                    //                            .font(.system(size: 12))
                                    //                        Text(viewModel.items.count == 1 ? "contribution this year" : "contributions this year")
                                    //                            .font(.system(size: 12))
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 0) {
                            Text("2024")
                                .foregroundColor(.gray)
                                .opacity(0.25)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        HStack {
                            let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 12)
                            LazyHGrid(rows: rows, spacing: 4) {
                                ForEach(monthlabel, id: \.self) { monthlabel in
                                    Text(monthlabel)
                                        .font(.system(size: 16))
                                        .textCase(.uppercase)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            LazyVGrid(columns: columns, spacing: 4) {
                                // Weekday abbreviations row
                                ForEach(Array(weekdays.enumerated()), id: \.offset) { index, weekday in
                                    VStack(spacing: 0) {
                                        Text(weekday)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                // Date cells
                                ForEach(getDates(), id: \.self) { date in
                                    ContributionCell(date: date ?? Date(), items: viewModel.items) {
                                        selectedDateWrapper = DateWrapper(date: date ?? Date())
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .sheet(item: $selectedDateWrapper) { dateWrapper in
                let selectedItems = viewModel.items.filter { itemModel in
                    Calendar.current.isDate(itemModel.timestamp, inSameDayAs: dateWrapper.date)
                }
                ItemDetailsView(items: selectedItems)
            }
            }
        .frame(width: .infinity, height: .infinity)
//        .padding(.vertical, 16)
        }
    
    struct DateWrapper: Identifiable {
        let id = UUID()
        let date: Date
    }
    
    struct ItemDetailsView: View {
        let items: [ItemModel]
        
        var body: some View {
            List(items) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    
                    if let imageData = item.imageData, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    }
                    
                    Text(item.timestamp, style: .date)
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("Items")
        }
    }
    
    func getDates() -> [Date?] {
        var dates = [Date?]()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        
        var startDay = 0
        
        for month in 1...12 {
            var components = DateComponents()
            components.year = year
            components.month = month
            
            if let firstDayOfMonth = calendar.date(from: components) {
                let daysInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
                
                if month == 1 {
                    startDay = calendar.component(.weekday, from: firstDayOfMonth) - 2 // Adjust start day (Sunday = 0)
                }
                
                // Add actual dates for the month
                for day in 1...daysInMonth {
                    components.day = day
                    if let date = calendar.date(from: components) {
                        dates.append(date)
                    }
                }
            }
        }
        
        // Add empty dates for the start day (only for the first month)
        for _ in 0..<startDay {
            dates.insert(nil, at: 0)
        }
        
        return dates
    }
    
    func getDay(_ date: Date?) -> Int? {
        guard let date = date else {
            return nil
        }
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    func isCurrentDate(_ date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: Date())
    }
}

struct ContributionsCalendar_Previews: PreviewProvider {
    static var previews: some View {
        ContributionsCalendar(viewModel: ListViewModel())
    }
}
