//
//  Post.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/13/23.
//

import UIKit

class Post {
    
    var postTitle: String
    var postDate: Date
    var postBody: String
    var postImage: UIImage?
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        ["Title": self.postTitle,
         "Date": self.postDate,
         "Body": self.postBody,
         "Image": self.postImage,
         "uuid": self.uuid
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

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
