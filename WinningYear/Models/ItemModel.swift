//
//  ItemModel.swift
//  WinningYear
//
//  Created by Barbara on 18/01/2024.
//

import Foundation

struct ItemModel: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let timestamp: Date // Add a timestamp
    let imageData: Data? // Add this line

    init(id: String = UUID().uuidString, title: String, timestamp: Date, imageData: Data?) {
        self.id = id
        self.title = title
        self.timestamp = timestamp
        self.imageData = imageData
    }
}

func getSampleDate(offset: Int)->Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}


