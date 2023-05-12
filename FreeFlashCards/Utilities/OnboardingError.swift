//
//  OnboardingError.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 5/12/23.
//

import Foundation

enum OnboardingError {
    case accountDoesntExist
    case somethingWentWrong
}

extension OnboardingError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .accountDoesntExist:
            return "Account Doesn't Exist"
        case .somethingWentWrong:
            return "Something Went Wrong"
        }
    }
    
    var message: String {
        switch self {
        case .accountDoesntExist:
            return "Unfortunately we couldn't find an account with this Sign-In method. Try again with different Sign-In method or create a new account."
        case .somethingWentWrong:
            return"Unfortunately we couldn't create an account with this Sign-Up method for some reason."
        }
    }
    
    var suggestion: String {
        switch self {
        case .accountDoesntExist:
            return "Confirm"
        case .somethingWentWrong:
            return "Try Again"
        }
    }
}
