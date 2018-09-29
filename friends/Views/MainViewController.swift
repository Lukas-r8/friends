//
//  MainViewController.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 26/08/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage

class MainViewController: UIViewController {
    var firebaseAuth = Auth.auth()
    var firebaseRef = Database.database().reference(fromURL: "https://friends-be9c9.firebaseio.com/")
    var userData = [String:AnyObject]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationController?.extensionSetNavigationControllerBar(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        getCurrentUserData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
    }
    
    
    
    
    func getCurrentUserData(){
        guard let uid = firebaseAuth.currentUser?.uid else {return}
        firebaseRef.child("users").child(uid).observe(DataEventType.value) { (snapshot) in
            //Retrieve data from database... (users, name)
                if let dictData = snapshot.value as? [String:AnyObject]{
                    self.userData = dictData
                    self.navigationItem.title = dictData["name"] as? String
                    self.view.reloadInputViews()
                }
        }
            
    }
    
    
    

    
    
    @objc func handleLogout(){
        do {
            try  firebaseAuth.signOut()
            print("logged out")
            self.dismiss(animated: true)
            print("pay Attention to this",self.isBeingDismissed)
            if !self.isBeingDismissed {
                let loginPageVC = LoginPage()
                self.present(loginPageVC, animated: true, completion: nil)
            }
  
        }catch let error{
            print("error on sign out:", error)
            return
        }
    }
    
    
    deinit{
        
        print("deininininininiintializeddddddd?????????????")
        
        
    }


}

    
    








