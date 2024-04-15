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

    // Sample data for testing, replace it with your actual data source
    let items: [ItemModel] = [
        ItemModel(id: "1", title: "First item!", timestamp: Date(), imageData: nil)
        // Add more sample items as needed
    ]
    let weekdays: [String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

    let monthlabel: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 0) {
                Text("Contributions")
                    .font(.title3.bold())
                HStack(spacing: 0) {
                    Text("2024")
                        .foregroundColor(.gray)
                        .opacity(0.25)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                ScrollView (.vertical, showsIndicators: false) {
                    Text("You have won")
                    Text("32")
                        .font(.system(size: 128))
                        .padding(32)
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())
                    Text("times this year")
                        .padding(.bottom)
                    HStack {
                        let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 12)
                        LazyHGrid(rows: rows, spacing: 0) {
                            ForEach(monthlabel, id: \.self) { monthlabel in
                                Text(monthlabel)
                                    .textCase(.uppercase)
                                    .foregroundColor(.gray)
                                        }
                                    }

                        LazyVGrid(columns: columns, spacing: 8) {
                            // Weekday abbreviations row
                            ForEach(weekdays, id: \.self) { weekday in
                                Text(weekday)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            // Date cells
                            ForEach(getDates(), id: \.self) { date in
                                ContributionCell(date: date ?? Date(), items: viewModel.items)
                            }
                        }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(.horizontal)
                }
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
