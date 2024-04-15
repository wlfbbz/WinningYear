//
//  DateValueView.swift
//  WinningYear
//
//  Created by Barbara on 28/03/2024.
//

import SwiftUI

// Date Value Model...
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
