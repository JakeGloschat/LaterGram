//
//  User.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import Foundation

class User {
    
    var userFirstName: String
    var userLastName: String
    var userEmail: String
    var userAreaCode: String?
    var userUUID: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        ["userFirstName": self.userFirstName,
        "userLastName": self.userLastName,
        "userEmail": self.userEmail,
        "userAreaCode": self.userAreaCode,
         "userUUID": self.userUUID
         ]
    }
    
    init(userFirstName: String, userLastName: String, userEmail: String, userAreaCode: String? = nil, userUUID: String = UUID().uuidString) {
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userEmail = userEmail
        self.userAreaCode = userAreaCode
        self.userUUID = userUUID
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userUUID == rhs.userUUID
    }
}
