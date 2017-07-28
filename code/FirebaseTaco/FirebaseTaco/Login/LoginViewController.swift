//
//  LoginViewController.swift
//  FirebaseTaco
//
//  Created by Erick Camacho on 7/27/17.
//  Copyright © 2017 Incode. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
    if Auth.auth().currentUser != nil {
      self.performSegue(withIdentifier: "photos", sender: nil)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if let error = error {
      
      print(error.localizedDescription)
      return
    }
    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
    Auth.auth().signIn(with: credential) { (user, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      self.performSegue(withIdentifier: "photos", sender: nil)
    }
  }
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
  }
}
