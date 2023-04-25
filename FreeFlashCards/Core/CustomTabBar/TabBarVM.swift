//
//  TabBarVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 21.04.2023.
//

import Foundation

final class TabBarVM: ObservableObject {
    
    @Published var tabSelection: TabBarItem = .home
    
}
