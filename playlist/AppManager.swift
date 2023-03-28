//
//  AppManager.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 27/03/23.
//

import Foundation
import Combine

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func isAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "token") != nil
    }
}
