//
//  UserDB.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class UserDB: NSObject, NSCoding {

    var name: String
    var email: String

    init(name: String, email: String) {
        self.name = name
        self.email = email
        super.init()
    }

    required convenience init?(coder aDecoder: NSCoder) {

        if let name = aDecoder.decodeObject(forKey: "name") as? String,
            let email = aDecoder.decodeObject(forKey: "email") as? String {
            self.init(name: name, email: email)
        } else {
            return nil
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
    }
}

extension UserDB {

    static func map(userAPI: UserApi) -> UserDB {
        return UserDB(name: userAPI.name, email: userAPI.mail)
    }
}
