//
//  GoogleViewController.swift
//  FirebaseProject
//
//  Created by Archit Joshi on 26/07/22.
//

import UIKit
import GoogleSignIn
import SDWebImage
import Firebase

class ProfileViewController: UIViewController {
    
    /// Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    private var profile: MyUser?
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated: true)
        
        profileImage.sd_setImage(with: URL(string: profile!.photoURL))
        firstName.text = profile?.displayName ?? ""
        lastName.text = profile?.uid ?? ""
        email.text = profile?.email ?? ""

        // Do any additional setup after loading the view.
    }
    
    
    func configure(user: MyUser ){
        profile = user
    }
    

}
