//
//  FirebaseConnection.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 12/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth



class BackEnd: UIViewController {
//    static var shared = BackEnd()
 
    static var firebaseRef = Database.database().reference()
    
    static func fetchUsers(){
        firebaseRef.child("users").observe(.childAdded) { (snapshot) in
            
            guard let userDict = snapshot.value as? [String:AnyObject] else {return}
            
            print(userDict)
            
        }

    }

    
    
    
    
    
    
    
}
