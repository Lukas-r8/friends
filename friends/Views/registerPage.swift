//
//  registerPage.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 18/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

class RegisterPage: UIViewController{
    
    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "surname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.extensionAddPadding(left: 10, right: 10)

        return textField
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "surname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.extensionAddPadding(left: 10, right: 10)
        
        return textField
    }()
    
    let genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "surname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.extensionAddPadding(left: 10, right: 10)
        
        return textField
    }()
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
    
    
}
