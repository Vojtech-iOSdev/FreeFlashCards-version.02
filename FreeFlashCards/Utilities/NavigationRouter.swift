//
//  NavigationRouter.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/13/23.
//

import SwiftUI

final class NavigationRouter: ObservableObject {
    
    @Published var routes = [Route]()
    
    func push(to screen: Route) {
        routes.append(screen)
    }
    
    func reset() {
        routes = []
    }
}
