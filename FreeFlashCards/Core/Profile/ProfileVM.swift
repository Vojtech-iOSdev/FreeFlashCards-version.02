//
//  ProfileVM.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 24.04.2023.
//

import Foundation

final class ProfileVM: ObservableObject {
    
    @Published private(set) var userInfo: DBUser? = nil
    
    @MainActor
    func loadCurrentUserInfo() async throws {
        let authModel = try AuthenticationManager.shared.getAuthenticatedUser()
        self.userInfo = try await UserManager.shared.getUser(userID: authModel.uid)
    }
    
}
