//
//  Background.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 05.05.2023.
//

import SwiftUI

struct Background: View {
    var body: some View {
        RadialGradient(stops: [.init(color: Color("lighterColor"), location: 0.1),
                               .init(color: Color("darkerColor"), location: 0.7)],
                                center: .top,
                                startRadius: 1,
                                endRadius: 1000).ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
