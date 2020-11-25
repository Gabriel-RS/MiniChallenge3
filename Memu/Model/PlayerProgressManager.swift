//
//  PlayerProgressManager.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 25/11/20.
//

import Foundation

enum UserDefaultsKeys: String {
    case playerLevel = "playerLevel"
    case playerPoints = "playerPoints"
    case noteDoLevel = "noteDoLevel"
    case noteDoPoints = "noteDoPoints"
}

class PlayerProgressManager {
    
    let defaults = UserDefaults.standard
    static var shared: PlayerProgressManager = PlayerProgressManager()
    
    var playerLevel: Int {
        get {
            return defaults.integer(forKey: UserDefaultsKeys.playerLevel.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.playerLevel.rawValue)
        }
    }
    
    var playerPoints: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.playerPoints.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.playerPoints.rawValue)
        }
    }
    
    var noteDoLevel: Int {
        get {
            return defaults.integer(forKey: UserDefaultsKeys.noteDoLevel.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.noteDoLevel.rawValue)
        }
    }
    
    var noteDoPoints: Float {
        get {
            return defaults.float(forKey: UserDefaultsKeys.noteDoPoints.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.noteDoPoints.rawValue)
        }
    }
    
    private init() {
        
    }
    
}
