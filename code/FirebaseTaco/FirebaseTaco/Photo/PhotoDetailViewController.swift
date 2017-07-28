//
//  PhotoDetailViewController.swift
//  FirebaseTaco
//
//  Created by Erick Camacho on 7/28/17.
//  Copyright © 2017 Incode. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailViewController: UIViewController {

  var photo: Photo?
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.scrollView.minimumZoomScale = 1.0
    self.scrollView.maximumZoomScale = 5.0
    setupPhoto()
  }
  
  func setupPhoto() {
    guard let photo = photo else {
      return
    }
    photoImageView.af_setImage(withURL: photo.url)
  }
  
}

extension PhotoDetailViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.photoImageView
  }
}
