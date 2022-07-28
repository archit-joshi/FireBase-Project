//
//  ViewController.swift
//  FirebaseProject
//
//  Created by Archit Joshi on 25/07/22.
//

import UIKit
import FBSDKLoginKit
import FirebaseCore
import FirebaseAuth
import FBSDKLoginKit


class ViewController: UIViewController {
    
    /// Outlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    
    /// Variables
    let network = Network()
    let oAuthSignIn = OAuthSignIn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.'
//        network.refreshToken(userName: userName)
        
    }
    
    
    @IBAction func userBtn(_ sender: Any) {
        
//        self.userName.textAlignment = .center
//        self.userName.text = "wait ..."
//
//        network.getUser { result in
//            self.userName.textAlignment = .left
//            self.userName.text = result.refreshToken
//            self.network.refreshToken()
//        }
        
    }
    
    
    @IBAction func googleSignIn(_ sender: Any) {
        oAuthSignIn.googleSignIn {
            res in
            let googleScreen = self.storyboard?.instantiateViewController(withIdentifier: "GoogleViewController") as? ProfileViewController
            googleScreen?.configure(user: res)
            self.navigationController?.pushViewController(googleScreen!, animated: true)
        }
        
    }
    
    @IBAction func facebookSignIn(_ sender: Any) {
//        loginButton.sendActions(for: .touchUpInside)
        oAuthSignIn.facebookSignIn {
            res in
            let profileScreen = self.storyboard?.instantiateViewController(withIdentifier: "GoogleViewController") as? ProfileViewController
            profileScreen?.configure(user: res!)
            self.navigationController?.pushViewController(profileScreen!, animated: true)
        }
        
    }
    
}
