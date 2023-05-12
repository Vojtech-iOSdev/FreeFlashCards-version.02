//
//  CustomButtonStyle01.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 23.04.2023.
//

import SwiftUI

struct CustomButtonStyle01: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color("lighterColor"))
            .foregroundColor(Color("darkerColor"))
            .cornerRadius(10)
            .font(.system(.headline, design: .monospaced, weight: .medium))
    }
}

extension ButtonStyle where Self == CustomButtonStyle01 {
    static var customButtonStyle01: CustomButtonStyle01 { .init() }
}
