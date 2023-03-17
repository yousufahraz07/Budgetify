//
//  Extensions.swift
//  Budgetify
//
//  Created by Ahraz  Yousuf on 2023-03-16.
//

import Foundation
import SwiftUI
extension Color {
    
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericCAN : DateFormatter = {
        print("Intializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/DD/YYYY"
        
        return formatter
    }()
}

extension String{
    func dateParsed() -> Date{
        guard let parsedDate = DateFormatter.allNumericCAN.date(from: self) else { return Date() }
        return parsedDate
    }
}

extension Date : Strideable{
    
}

extension Double {
    func rounded2()->Double{
        return (self * 100).rounded()/100
    }
}
