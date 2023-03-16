//
//  ServiceRequestingImageView.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/15/23.
//

import UIKit



class ServiceRequestingImageView: UIImageView {
    
    var post: Post?
    let service = Firebaseservice()
    
    func fetchImage(using post: Post) {
        service.fetchImage(from: post) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    func setDefaultImage() {
        self.image = UIImage(named:"IMG_2880")
    }
}
