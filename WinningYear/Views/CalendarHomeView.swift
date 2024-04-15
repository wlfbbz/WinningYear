//
//  CalendarHomeView.swift
//  WinningYear
//
//  Created by Barbara on 26/03/2024.
//

import SwiftUI

struct CalendarHomeView: View {
    
    @State var currentDate: Date = Date()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
             
            VStack (spacing: 20) {
                
                // Custom Date Picker...
                CustomDatePickerView(currentDate: $currentDate)
            }
        }
        
    }
}

#Preview {
    CalendarHomeView()
}
