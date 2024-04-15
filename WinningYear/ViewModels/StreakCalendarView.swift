//
//  StreakCalendarView.swift
//  WinningYear
//
//  Created by Barbara on 16/03/2024.
//

import SwiftUI

struct StreakCalendarView: View {
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(months, id: \.self) { month in
                    MonthView(monthName: month)
                }
            }
            .padding()
        }
    }
}

struct MonthView: View {
    let monthName: String
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let daysInMonth = 31 // You can adjust this based on the actual number of days in the month
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(monthName)
                .font(.title)
                .bold()
            
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .frame(width: 30, height: 30)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            
            ForEach(0..<6) { row in
                HStack(spacing: 5) {
                    ForEach(0..<7) { col in
                        let day = (row * 7) + col + 1
                        if day <= daysInMonth {
                            Text("\(day)")
                                .frame(width: 30, height: 30)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(5)
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    StreakCalendarView()
}
