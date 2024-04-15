//
//  ContributionCell.swift
//  WinningYear
//
//  Created by Barbara on 28/03/2024.
//

import SwiftUI

struct ContributionCell: View {
    let date: Date
    let items: [ItemModel]
    
    var body: some View {
        let dayNumber = Calendar.current.component(.day, from: date)
        
        let hasContribution = items.contains { itemModel in
            Calendar.current.isDate(itemModel.timestamp, inSameDayAs: date)
        }
        
        return
            ZStack {
                Rectangle()
                    .fill(hasContribution ? Color.calendarevent/*.opacity(0.8)*/ : Color.gray.opacity(0.1))
                    .frame(width: 25, height: 25)
                    .cornerRadius(8)
                //            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1), lineWidth: 1))
//                Text("\(dayNumber)")
//                    .font(.system(size: 12, weight: .regular))
//                    .foregroundColor(.black)
            }
        }
    }

struct ContributionCell_Preview: PreviewProvider {
    static var previews: some View {
        ContributionCell(date: Date(), items: [ItemModel(id: "1", title: "First item!", timestamp: Date(), imageData: nil)])
            .previewLayout(.fixed(width: 25, height: 25))
    }
}
