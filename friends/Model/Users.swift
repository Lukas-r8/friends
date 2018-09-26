//
//  Users.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 01/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import UIKit
import Foundation

class Users: NSObject {

    let defaultProfileImage = UIImage(named: "emptyProfileImage")
    var profileImage: UIImage?
    let name: String? = nil
    let surname: String? = nil
    var age: Int?
    var gender: String?
    var city: String?
    var interests: [InterestsEnum]?
    var nationality: String?
    var profileDescription: String?
    var events: [Event]?
    var id = UUID().uuidString
    
}
