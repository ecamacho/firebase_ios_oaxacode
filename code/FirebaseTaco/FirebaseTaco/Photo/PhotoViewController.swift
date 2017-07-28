//
//  PhotoViewController.swift
//  FirebaseTaco
//
//  Created by Erick Camacho on 7/27/17.
//  Copyright © 2017 Incode. All rights reserved.
//

import UIKit
import AlamofireImage
import FirebaseStorage

class PhotoViewController: UIViewController {
  
  var photos = [Photo]()
  
  var selectedPhoto: Photo?
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var activityView: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = false
    self.navigationItem.hidesBackButton = true
    NotificationCenter.default.addObserver(self, selector: #selector(photoAdded(notification:)),
                                           name: .photoAdded,
                                           object: nil)
    PhotoLibrary.observe()
  }
  
  @IBAction func takePhoto() {
    let picker = UIImagePickerController()
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      picker.sourceType = .camera
      picker.cameraCaptureMode = .photo
    } else {
      picker.sourceType = .photoLibrary
    }
    picker.allowsEditing = false
    picker.delegate = self
    DispatchQueue.main.async {
      self.present(picker, animated: true, completion: nil)
    }
  }
  
  @objc func photoAdded(notification: Notification) {
    if let photo = notification.userInfo?["photo"] as? Photo {
      DispatchQueue.main.async {
        self.appendPhoto(photo: photo)
      }
    }
  }
  
  func appendPhoto(photo: Photo) {
    //buscar que no está ya siendo mostrada
    let isDisplayed = self.photos.reduce(false) { (isDisplayed, ph) -> Bool in
      return isDisplayed || ph.name == photo.name
    }
    if !isDisplayed {
      self.photos.append(photo)
      let indexPath = IndexPath(row: self.photos.count - 1, section: 0)
      self.collectionView.insertItems(at: [indexPath])
    }
  }
  
  func showActivityIndicator() {
    self.activityView.isHidden = false
    self.activityView.startAnimating()
  }
  
  func stopActivityIndicator() {
    self.activityView.stopAnimating()
    self.activityView.isHidden = true
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detail = segue.destination as? PhotoDetailViewController {
      detail.photo = self.selectedPhoto
    }
    
  }
  
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

extension PhotoViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
    if let cell = cell as? PhotoCell {
      cell.photoImageView.af_setImage(withURL: photos[indexPath.row].url)
    }
    return cell
  }
  
}

extension PhotoViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    self.selectedPhoto = photos[indexPath.row]
    return true
  }
}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    self.dismiss(animated: true, completion: nil)
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      self.showActivityIndicator()
      DispatchQueue.global().async {
        PhotoLibrary.upload(image: image) { (error, photo) in
          DispatchQueue.main.async {
            self.stopActivityIndicator()
            if let error = error {
              self.showAlert(title: "Error", message: error)
            } else if let photo = photo {
              
              self.appendPhoto(photo: photo)
            }
          }
        }
      }
    }
  }
}
