//
//  KeyedArchiverManager.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class KeyedArchiverManager {

    static func saveObjectWith(key: String, object: NSObject?) {
        // guard let object = object else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object as Any, requiringSecureCoding: false) as Data?
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        } catch let error {
            print("Failed to save object: \(error)")
        }
    }

    static func retrieveObjectWith<T: NSObject>(key: String, type: T.Type) -> T? {

        do {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
                let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T {
                return object
            }
        } catch let error {
            print("Failed to get object: \(error)")
        }
        return nil
    }

    static func saveBoolWith(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func retrieveBoolWith(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

    static func saveStringWith(key: String, text: String) {
        UserDefaults.standard.set(text, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func retrieveStringWith(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    static func saveTimeWith(key: String, value: TimeInterval) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func retrieveTimeWith(key: String) -> TimeInterval? {
        return UserDefaults.standard.double(forKey: key)
    }
}
