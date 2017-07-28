//
//  File.swift
//  FirebaseTaco
//
//  Created by Erick Camacho on 7/27/17.
//  Copyright © 2017 Incode. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  func showAlert(title: String, message: String) {
    let alert: UIAlertController = UIAlertController(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
    let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (action) in
    }
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }
}
