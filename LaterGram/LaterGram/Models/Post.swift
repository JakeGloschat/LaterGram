//
//  Post.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit

class Post {
    
    enum Key {
        static let title = "title"
        static let date = "date"
        static let body = "body"
        static let image = "image"
        static let uuid = "uuid"
        static let collectionType = "posts"
    }
    
    var postTitle: String
    var postDate: Date
    var postBody: String
    var postImage: UIImage?
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [Key.title: self.postTitle,
         Key.date: self.postDate.timeIntervalSince1970,
         Key.body: self.postBody,
         Key.image: self.postImage,
         Key.uuid: self.uuid
        ]
    }
    
    init(postTitle: String, postDate: Date = Date(), postBody: String, postImage: UIImage? = nil, uuid: String = UUID().uuidString) {
        self.postTitle = postTitle
        self.postDate = postDate
        self.postBody = postBody
        self.postImage = postImage
        self.uuid = uuid
    }
}

extension Post {
    convenience init?(fromDictionary dictionary: [String: Any]) {
        guard let title = dictionary[Key.title] as? String,
              let date = dictionary[Key.date] as? Double,
              let body = dictionary[Key.body] as? String,
             // let image = dictionary[Key.image] as? UIImage,
              let uuid = dictionary[Key.uuid] as? String else
        {print("Failed to initialize object ; Check the date") ; return nil }
        //TODO: ADD IMAGE
        self.init(postTitle: title, postDate: Date(timeIntervalSince1970: date), postBody: body, uuid: uuid)
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
