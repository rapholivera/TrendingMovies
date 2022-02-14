//
//  UserSessionDB.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class UserSessionDB: NSObject, NSCoding {

    private(set) var accessToken: String
    private(set) var currentUser: UserDB

    init(accessToken: String, currentUser: UserDB) {
        self.accessToken = accessToken
        self.currentUser = currentUser
    }

    required convenience init?(coder aDecoder: NSCoder) {
        if let accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String,
            let currentUser = aDecoder.decodeObject(forKey: "currentUser") as? UserDB {
            self.init(accessToken: accessToken, currentUser: currentUser)
        } else {
            return nil
        }
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(currentUser, forKey: "currentUser")
    }
}
