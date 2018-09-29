//
//  LoginPage.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 08/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginPage: UIViewController {
    
    var firebaseAuth = Auth.auth()
    var firebaseRef = Database.database().reference(fromURL: "https://friends-be9c9.firebaseio.com/")
    
    var registerButtonLayout: NSLayoutConstraint?
    var emailFieldLayout: NSLayoutConstraint?
    var passwordFieldLayout: NSLayoutConstraint?
    
    var loginButtonLayout: NSLayoutConstraint?
    var loginEmailFieldLayout: NSLayoutConstraint?
    var loginPasswordFieldLayout: NSLayoutConstraint?
    
    // constraint created to move the texts fields according to keyboard position...
    var containerViewYanchor: NSLayoutConstraint?
    
    var distanceButtonFromViewBottom: CGFloat?
    
    lazy var circularViewPhoto: UIView = {
        let photoView = UIImageView()
        photoView.backgroundColor = UIColor.orange
        photoView.layer.cornerRadius = 200 / (6 + 1/3)
        photoView.contentMode = UIViewContentMode.scaleToFill
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.clipsToBounds = true
        
        let image = UIImage(named: "eventBowling")
        photoView.image = image
        
        let containerImageView = UIView()
        containerImageView.layer.cornerRadius = 200 / (6 + 1/3)
        containerImageView.addSubview(photoView)
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        containerImageView.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 1, height: 3))
        containerImageView.extensionSetConstraintsWithFormat(horizontalFormat: "|[v0]|", verticalFormat: "|[v0]|", views: [photoView])
        
        return containerImageView
    }()
    

    
    let containerView: UIView = {
        let cont = UIView()
        cont.layer.cornerRadius = 10
        cont.translatesAutoresizingMaskIntoConstraints = false
        cont.backgroundColor = .clear
        return cont
    }()
    
    
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "name"
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .white
        textField.extensionAddPadding(left: 10, right: 10)
        textField.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "email"
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .white
        textField.extensionAddPadding(left: 10, right: 10)
        textField.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "password"
        textField.layer.cornerRadius = 25
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.extensionAddPadding(left: 10, right: 10)
        textField.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["Register","Login"])
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.selectedSegmentIndex = 0
          seg.addTarget(self, action: #selector(toggleLoginRegister), for: .valueChanged)
        return seg
    }()
    
    lazy var registerLoginButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLoginRegisterButton), for: .touchUpInside)
        return button
    }()
    
    let activityView: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.whiteLarge)
        act.translatesAutoresizingMaskIntoConstraints = false
        act.hidesWhenStopped = true
        return act
    }()
    
    override func viewDidLayoutSubviews() {
        // get the CGRect of subviews after layout is done....
        distanceButtonFromViewBottom = view.frame.height - (registerLoginButton.frame.origin.y + 50)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        containerView.extensionAddSubViewAtOnce(UIViews: nameTextField,emailTextField,passwordTextField)
        
        view.extensionAddSubViewAtOnce(UIViews: containerView,segmentedControl,registerLoginButton,circularViewPhoto)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
                
        circularViewPhotoAddConst()
        containerViewAddConst()
        nameTextFieldAddConst()
        emailTextFieldAddConst()
        passwordTextFieldAddConst()
        segmentedControlAddConst()
        registerLoginButtonAddConst()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeConstraintsForKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        containerViewYanchor?.constant = 75
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
 
    }
    
    
    func emptyAllTextFields(){
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
  
    }

    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        
        containerViewYanchor?.constant = 75
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    // add some warning message for the user...
    func showAlertModal(title: String, Message: String){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
  

}
