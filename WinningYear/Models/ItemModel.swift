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
    
    init(id: String = UUID().uuidString, title: String, timestamp: Date) {
        self.id = id
        self.title = title
        self.timestamp = timestamp
    }
}

