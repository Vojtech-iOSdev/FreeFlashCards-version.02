//
//  DependencyInjection.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 01.05.2023.
//

import Foundation

public protocol InjectionKey {
    
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath <InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

// MARK: DEPENDENCY KEYS
// if u wanna add another dependency recreate new key with new dependency
private struct UserManagerKey: InjectionKey {
    static var currentValue: UserManagerProtocol = UserManager()
}

private struct AuthenticationManagerKey: InjectionKey {
    static var currentValue: AuthenticationManagerProtocol = AuthenticationManager()
}

private struct CoursesManagerKey: InjectionKey {
    static var currentValue: CoursesManagerProtocol = CoursesManager()
}

// MARK: INJECTED VALUES EXT
// if u wanna add another dependency add extension on InjectedValues
extension InjectedValues {
    var userManager: UserManagerProtocol {
        get { Self[UserManagerKey.self] }
        set { Self[UserManagerKey.self] = newValue }
    }
}

extension InjectedValues {
    var authenticationManager: AuthenticationManagerProtocol {
        get { Self[AuthenticationManagerKey.self] }
        set { Self[AuthenticationManagerKey.self] = newValue }
    }
}

extension InjectedValues {
    var coursesManager: CoursesManagerProtocol {
        get { Self[CoursesManagerKey.self] }
        set { Self[CoursesManagerKey.self] = newValue }
    }
}
