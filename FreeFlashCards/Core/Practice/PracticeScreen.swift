//
//  PracticeScreen.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import SwiftUI

struct PracticeScreen: View {
    
    @StateObject private var vm: PracticeVM
    
    init(vm: PracticeVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PracticeScreen_Previews: PreviewProvider {
    static var previews: some View {
        PracticeScreen(vm: PracticeVM(userManager: UserManager()))
    }
}
