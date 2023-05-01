//
//  PracticeScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct PracticeScreen: View {
    
    @StateObject private var vm: PracticeVM = .init()
        
    var body: some View {
        VStack {
            Text(vm.text)
            
            Button("call func") {
                vm.showText()
            }
            .buttonStyle(.customButtonStyle01)
        }
    }
}

struct PracticeScreen_Previews: PreviewProvider {
    static var previews: some View {
        PracticeScreen()
    }
}
