////
////  CustomDatePickerView.swift
////  WinningYear
////
////  Created by Barbara on 26/03/2024.
////
//
//import SwiftUI
//
//struct CustomDatePickerView: View {
//    @Binding var currentDate: Date
//    
//    // Month update on arrow button clicks...
//    @State var currentMonth: Int = 0
//    
//    // Array of sample items
//    let sampleItems: [ItemModel] = [
//        ItemModel(title: "Sample Item 1", timestamp: getSampleDate(offset: -3), imageData: nil),
//        // Add more sample items as needed
//    ]
//    
//    var body: some View {
//        
//        VStack {
//                Spacer()
//                HStack {
//                    VStack {
//                        Text(extraDate()[1])
//                            .font(.caption)
//                            .fontWeight(.semibold)
//                        Text(extraDate()[0])
//                            .font(.caption.bold())
//                    }
//                    
//                    Spacer(minLength: 8)
//                    
//                    VStack (spacing: 25) {
//                        
//                    HStack(spacing: 0) {
//                        
//                        // Days...
//                        let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//                        
//                        // Day View...
//                        
//                        ForEach(days,id: \.self){day in
//                            
//                            Text(day)
//                                .font(.callout)
//                                .fontWeight(.semibold)
//                                .frame(maxWidth: .infinity)
//                        }
//                    }
//                        // Dates....
//                        // Lazy Grid..
//                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
//                        
//                        LazyVGrid(columns: columns,spacing: 15) {
//                            
//                            ForEach(extractDate()){value in
//                                
//                                CardView(value: value)
//                                    .background(
//                                    
//                                        Capsule()
//                                            .fill(Color.pink)
//                                            .padding(.horizontal, 8)
//                                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
//                                    )
//                                    .onTapGesture {
//                                        currentDate = value.date
//                                    }
//                            }
//                        }
//                }
//                }
//            
//                .padding(.horizontal)
//            }
//    }
//    
//    @ViewBuilder
//    func CardView(value: DateValue)->some View{
//        
//        VStack {
//            if value.day != -1{
//                
//                if let item = sampleItems.first(where: { item in
//
//                    return isSameDay(date1: item.timestamp, date2: value.date)
//                }){
//                    Text("\(value.day)")
//                        .font(.title3.bold())
//                        .foregroundColor(isSameDay(date1: item.timestamp, date2: currentDate) ? .white : .primary)
//                        .frame(maxWidth: .infinity)
//                    
//                    Spacer()
//                    
//                    Circle()
//                        .fill(isSameDay(date1: item.timestamp, date2: currentDate) ? .white : Color.pink)
//                        .frame(width: 8, height: 8)
//                }
//                else{
//                    
//                    Text("\(value.day)")
//                        .font(.title3.bold())
//                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
//                        .frame(maxWidth: .infinity)
//                    
//                    Spacer()
//                }
//            }
//        }
//        .padding(.vertical, 8)
//        .frame(height: 60, alignment: .top)
//    }
//    
//    // checking dates...
//    func isSameDay(date1: Date,date2: Date)->Bool{
//        let calendar = Calendar.current
//        
//        return calendar.isDate(date1, inSameDayAs: date2)
//        
//    }
//    
//    // extracting Year And Month for display...
//    func extraDate()->[String]{
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY MMMM"
//        
//        let date = formatter.string(from: currentDate)
//        
//        return date.components(separatedBy: " ")
//    }
//    
//    func getCurrentMonth()->Date{
//        
//        let calendar = Calendar.current
//
//        // Getting Current Month Date....
//        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
//            return Date()
//        }
//        
//        return currentMonth
//        
//    }
//    
//    func extractDate()->[DateValue]{
//        
//        let calendar = Calendar.current
//
//        // Getting Current Month Date....
//        let currentMonth = getCurrentMonth()
//        
//       var days = currentMonth.getAllDates().compactMap { date -> DateValue in
//            
//            // getting day...
//            let day = calendar.component(.day, from: date)
//            
//            return DateValue(day: day, date: date)
//        }
//        
//        // adding offset days to get exact week day...
//        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
//        
//        for _ in 0..<firstWeekday - 1{
//            days.insert(DateValue(day: -1, date: Date()), at: 0)
//        }
//        
//        return days
//    }
//        
//    }
//
//struct CustomDatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarHomeView()
//    }
//}
//
//// Extending Date to get Current Month Dates...
//extension Date {
//    
//    func getAllDates()->[Date]{
//        
//        let calendar = Calendar.current
//        
//        // getting start Date...
//        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month],from: self))!
//        
//        let range = calendar.range(of: .day, in: .month, for: startDate)!
//        
//        // getting date...
//        return range.compactMap { day -> Date in
//            
//            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
//        }
//    }
//}
// 
