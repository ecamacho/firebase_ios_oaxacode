//
//  Photo.swift
//  FirebaseTaco
//
//  Created by Erick Camacho on 7/27/17.
//  Copyright © 2017 Incode. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct Photo {
  var name: String
  var url: URL
}

class PhotoLibrary {

  typealias UploadResult = (String?, Photo?) -> Void

  static let storage = Storage.storage()
  static let database = Database.database().reference()
  
  class func upload(image: UIImage, completion: @escaping UploadResult) {
    let storageRef = storage.reference()
    let photoName = UUID().uuidString
    let photoRef = storageRef.child("photos/\(photoName).jpg")
    if let data = UIImageJPEGRepresentation(image, 0.5) {
      let uploadTask =  photoRef.putData(data,
                                         metadata: nil) { (metadata, error) in
                                          guard let metadata = metadata else {
                                            completion("Ocurrió un error, intenta de nuevo",
                                                       nil)
                                            return
                                          }
                                          if let error = error {
                                            completion(error.localizedDescription,
                                                       nil)
                                          } else {
                                            if let downloadUrl = metadata.downloadURL() {
                                              savePhoto(name: photoName,
                                                        downloadUrl: downloadUrl)
                                              completion(nil, Photo(name: photoName, url: downloadUrl))
                                            } else {
                                              completion("Empty url",
                                                         nil)
                                            }
                                          }
      }
      uploadTask.resume()
    }
  }

  class func savePhoto(name: String, downloadUrl: URL) {
    database.ref.child("photos").child(name).setValue(
      ["name": name,
       "url": downloadUrl.absoluteString]
    )
  }

  class func observe() {
    database.ref.child("photos").observe(.childAdded) { snapshot in
      if let photoInfo = snapshot.value as? [String: Any?] {
        guard let name = photoInfo["name"] as? String else {
          return
        }
        guard let url = photoInfo["url"] as? String  else {
          return
        }
        guard let photoUrl = URL(string: url)  else {
          return
        }
        let photo = Photo(name: name, url: photoUrl)
        NotificationCenter.default.post(name: .photoAdded,
                                        object: nil,
                                        userInfo: ["photo": photo])
      }      
    }
  }
  
}
