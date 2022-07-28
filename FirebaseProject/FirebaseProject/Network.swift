//
//  Network.swift
//  FirebaseProject
//
//  Created by Archit Joshi on 25/07/22.
//

import Foundation
import UIKit
import Alamofire
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class Network{
    
    let url = "https://dev-api.connectup.com/api/login_v2"
    
    
    var requestBody = RequestBody(token: "", fcmToke: "token", appName: "ConnectUp", platform: "web" , modelName: nil, osVersion: nil, appVersion: nil, deviceId: nil, email: "amitpaliwal259@gmail.com", password: "amit@123")
    
    
    func getResponse(_ completion: @escaping (_ result: ResponseBody)->()){
        AF.request(url, method: .post, parameters: requestBody, encoder: JSONParameterEncoder.default).response{
            response in
            do{
                let dataa = try JSONDecoder().decode(ResponseBody.self, from: response.data!)
                completion(dataa)
            }
            catch{
                print("someting is wrong")
            }
        }
    }
    
    func getUser(_ completion: @escaping (_ result: User)->()){
        getResponse { result in
            let customToken = result.customToken
//            print("customToken", customToken)
            Auth.auth().signIn(withCustomToken: customToken ) { user, error in
                completion(user!.user)
            }
        }
    }
    
    func refreshToken(){
        do{
            Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: {
                token, error in
                print("token",token)
            })
        }
        catch{
            print("...")
        }
        
    }
    
}



class OAuthSignIn {
    var myUser: MyUser?
    
    func googleSignIn(_ navigateTo: @escaping (_ result : MyUser) -> () ){
    
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: (UIApplication.shared.keyWindow?.rootViewController)! ) { [unowned self] user, error in

            if error != nil { return }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ [self]
                result, error in
                if error != nil{ return }
                guard let user = result?.user else {return}
//                print("name:",user.displayName!,"  email", user.email!)
                myUser = MyUser(photoURL: "\(user.photoURL!)", displayName: user.displayName!, uid: user.uid, email: user.email!)
                navigateTo(myUser!)
            }
        }
    }
    

    func facebookSignIn(_ navigateTo: @escaping (_ result : MyUser?) -> () ){
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile","email"], from: ViewController())  {
            loginResult,error   in
            if let error = error {
                 print(error.localizedDescription)
               return
               }
            let graphRequest:GraphRequest = GraphRequest(graphPath:"me", parameters: ["fields":"first_name,last_name,email, picture.type(large)"])
            graphRequest.start(completion: { [self] (connection, result, error) -> Void in
                if ((error) != nil) {
                    print("Error: \(String(describing: error))")
                }
                else {
                    let data:[String:AnyObject] = result as! [String : AnyObject]
                    
                    myUser = MyUser(photoURL: "", displayName: "\( data["first_name"]!) \( data["last_name"]!)", uid: data["id"] as! String, email: data["email"] as! String)
                    
                    if let profilePicURL = ((data["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                        UserDefaults.standard.set(profilePicURL, forKey: "profilePic")
                        myUser?.photoURL = profilePicURL
                    }
                    print("res", data)

                    navigateTo(self.myUser!)
                }
            })
            
        }
    }
    
}
