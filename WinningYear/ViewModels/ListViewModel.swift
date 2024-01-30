//
//  ListViewModel.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

/* CRUD FUNCTIONS
 Create
 Read
 Update
 Delete
 */


import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
//        addTestItems() // Call the test function for development/testing purposes
    }
    
    func getItems() {
        guard 
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(period: String, indexSet: IndexSet) {
        guard let index = indexSet.first,
              let periodItems = itemsGroupedByPeriod[period],
              let itemToDelete = periodItems[safe: index] else {
            return
        }

        if let globalIndex = items.firstIndex(where: { $0.id == itemToDelete.id }) {
            items.remove(at: globalIndex)
        }
    }



    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, timestamp: Date())
        items.insert(newItem, at: 0) // Insert the new item at the beginning of the array
    }


    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    var itemsGroupedByPeriod: [String: [ItemModel]] {
            Dictionary(grouping: items, by: { item in
                let calendar = Calendar.current
                let now = Date()
                
                if calendar.isDateInToday(item.timestamp) {
                    return "Today"
                } else if calendar.isDateInYesterday(item.timestamp) {
                    return "Yesterday"
                } else if calendar.isDate(item.timestamp, inSameDayAs: now) {
                    return "Today"
                } else if let daysAgo = calendar.dateComponents([.day], from: item.timestamp, to: now).day, daysAgo <= 7 {
                    return "Last 7 Days"
                } else if let daysAgo = calendar.dateComponents([.day], from: item.timestamp, to: now).day, daysAgo <= 30 {
                    return "Last 30 Days"
                } else if let monthsAgo = calendar.dateComponents([.month], from: item.timestamp, to: now).month, monthsAgo <= 6 {
                    return "Last 6 Months"
                } else {
                    let yearFormatter = DateFormatter()
                    yearFormatter.dateFormat = "yyyy"
                    return yearFormatter.string(from: item.timestamp)
                }
            })
        }
    
    // Add this function in ListViewModel

//    // Function to add test items for various periods, including past 5 years
//    func addTestItems() {
//        let calendar = Calendar.current
//        let now = Date()
//
//        // Add items for fixed periods
//        let testDates = [
//            calendar.date(byAdding: .day, value: 0, to: now),    // Today
//            calendar.date(byAdding: .day, value: -1, to: now),   // Yesterday
//            calendar.date(byAdding: .day, value: -3, to: now),   // Last 7 Days
//            calendar.date(byAdding: .day, value: -15, to: now),  // Last 30 Days
//            calendar.date(byAdding: .month, value: -2, to: now), // Last 6 Months
//        ]
//
//        for date in testDates where date != nil {
//            let newItem = ItemModel(title: "Test \(date!)", timestamp: date!)
//            items.append(newItem)
//        }
//
//        // Add items for the past 5 years
//        for year in 1...5 {
//            if let pastYearDate = calendar.date(byAdding: .year, value: -year, to: now) {
//                let newItem = ItemModel(title: "Test Year \(calendar.component(.year, from: pastYearDate))", timestamp: pastYearDate)
//                items.append(newItem)
//            }
//        }
//    }

}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

