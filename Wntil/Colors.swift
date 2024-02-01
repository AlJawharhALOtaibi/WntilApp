//
//  Colors.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 09/07/1445 AH.
//  This Page contains the custmize colors. 

import SwiftUI

extension Color {
    
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

extension Color {
    static let customRed = Color(hex: 0xFF004F)
    static let customBlue = Color(hex: 0x2D1A8E)
    static let customLightBlue = Color(hex: 0xBDABE4)

}



