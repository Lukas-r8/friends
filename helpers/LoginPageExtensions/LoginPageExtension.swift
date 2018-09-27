//
//  LoginPageExtensionConstraints.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 12/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit

// CONSTRAINTS, AND UPDATE CONSTRAINTS EXTENSION -----------------------------------------------------------|

extension LoginPage{
 
    func circularViewPhotoAddConst(){
        circularViewPhoto.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -20).isActive = true
        circularViewPhoto.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        circularViewPhoto.widthAnchor.constraint(equalToConstant: 200).isActive = true
        circularViewPhoto.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    func containerViewAddConst(){
        
        containerViewYanchor =  containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 75)
        containerViewYanchor?.isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
    }
    
    
    func nameTextFieldAddConst(){
        nameTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    func emailTextFieldAddConst(){
        emailFieldLayout = emailTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        emailFieldLayout?.isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
    func passwordTextFieldAddConst(){
        passwordFieldLayout = passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 75)
        passwordFieldLayout?.isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
    func segmentedControlAddConst(){
        segmentedControl.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
    func registerLoginButtonAddConst(){
        
        registerButtonLayout =  registerLoginButton.centerYAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 45)
        registerButtonLayout?.isActive = true
        
        registerLoginButton.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        registerLoginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerLoginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
    }
    
    
    func changeConstraintsForLogin(){
        passwordFieldLayout?.isActive = false
        loginPasswordFieldLayout = passwordTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        loginPasswordFieldLayout?.isActive = true
        
        emailFieldLayout?.isActive = false
        loginEmailFieldLayout = emailTextField.centerYAnchor.constraint(equalTo: containerView.topAnchor, constant: 25)
        loginEmailFieldLayout?.isActive = true
        
        registerButtonLayout?.isActive = false
        loginButtonLayout = registerLoginButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 70)
        loginButtonLayout?.isActive = true
    }
    
    func changeConstraintsForRegister(){
        loginPasswordFieldLayout?.isActive = false
        passwordFieldLayout?.isActive = true
        
        loginEmailFieldLayout?.isActive = false
        emailFieldLayout?.isActive = true
        
        loginButtonLayout?.isActive = false
        registerButtonLayout?.isActive = true
    }
    
    
    
    @objc func changeConstraintsForKeyboard(keyboardInfo: NSNotification){
        
        if let dictionary = keyboardInfo.userInfo{
            let keyboardFrame = dictionary[UIKeyboardFrameEndUserInfoKey] as! CGRect
            
            let keybHeight = keyboardFrame.height
            guard let offset = distanceButtonFromViewBottom else {return}
            
            let movementConstant = (-keybHeight + offset) - 10
            
            containerViewYanchor?.constant += movementConstant
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
    
    
    
}



//PICKER VIEW, TEXT FIELD, EXTENSION-----------------------------------------------------------------------|


extension LoginPage: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

   
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    

    
}

//FIREBASE CONNECTION, REGISTER , LOGIN----------------------------------------------------------| EXTENSION

extension LoginPage {
    
    
    
    // register user
    @objc func handleLoginRegisterButton(){
        self.view.endEditing(true)
        guard let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) else {return}
        
        // safe unwrapping...
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {return}
        
        // if text fields don't match requirements throw an alert
        if password.count < 6 {self.showAlertModal(title: "\(title) Failed", Message: "Password must contain at least 6 characters"); return}
        
        if segmentedControl.selectedSegmentIndex == 0 {
            print("register button")
            // if text fields don't match requirements throw an alert
            if name.count < 1 || email.count < 1 { self.showAlertModal(title: "\(title) Failed", Message: "Please, fill in all the fields"); return}
            
            
            // register user on firebase...
            self.handleRegister(email: email, password: password, name: name) { (registerSucess)  in
                if registerSucess {
                    self.handleLogin(email: email, password: password)
                }
            }
            
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            print("login button")
            // if text fields don't match requirements throw an alert
            if email.count < 1 { self.showAlertModal(title: "\(title) Failed", Message: "Please, fill in all the fields"); return}
            
            handleLogin(email: email, password: password)
            
        }
    }
    
    
    func handleRegister(email: String, password: String, name: String, completion: @escaping (Bool) -> Void){
        
        addRemoveActivity(add: true, loadMessage: "Registering")
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.firebaseAuth.createUser(withEmail: email, password: password) { (res, error) in
                
                if let err = error {
                    print("not possible to register:",err)
                    self.showAlertModal(title: "Register Failed", Message: err.localizedDescription)
                    self.addRemoveActivity(add: false, loadMessage: "")

                    return
                }
                self.firebaseAuth.currentUser?.sendEmailVerification(completion: { (err) in
                    print("email sent")
                    if err != nil {print(err!.localizedDescription); self.addRemoveActivity(add: false, loadMessage: ""); return}
                })
                guard let uid = res?.user.uid else {self.addRemoveActivity(add: false, loadMessage: ""); return}
                let userRef = self.firebaseRef.child("users").child(uid)
                let values = ["name":name,"email":email]
                
                userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let error = err {
                        print("error upon updateChildValues registering: ",error)
                        self.addRemoveActivity(add: false, loadMessage: "")
                        return
                        
                    }
                    
                    print("updated sucessfully, reference:",ref)
                    
                    completion(true)
                })
                
                print("Authentication result: ", res?.user.displayName ?? "failed auth")
                self.addRemoveActivity(add: false, loadMessage: "")

            }
            
                
            
            
        }
        
    }
    
    
    
    
    func handleLogin(email: String, password: String){
        addRemoveActivity(add: true, loadMessage: "Login...")
        DispatchQueue.global(qos: .userInteractive).async {
            
            self.firebaseAuth.signIn(withEmail: email, password: password) { (res, err) in
                if let error = err {
                    print(error)
                    self.showAlertModal(title: "Login Failed", Message: error.localizedDescription)
                    self.addRemoveActivity(add: false, loadMessage: "")
                    return
                }
                
                print("loginSucessful:", res?.description ?? "description nil")
                let customTabBarControllerVCS = CustomTabBarController()
                self.present(customTabBarControllerVCS, animated: true, completion: {
                    AppDelegate.window?.rootViewController = customTabBarControllerVCS
                    self.addRemoveActivity(add: false, loadMessage: "")
                })

            }
            
        }

    }
    
    //segmented control login/Register
    
    @objc func toggleLoginRegister(){
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        registerLoginButton.setTitle(title, for: .normal)
        
        
        if segmentedControl.selectedSegmentIndex == 0 {
            changeConstraintsForRegister()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.nameTextField.alpha = 1
            })
            
            
        } else if segmentedControl.selectedSegmentIndex == 1{
            self.changeConstraintsForLogin()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.nameTextField.alpha = 0
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
    
    
    
    
    // Activity Indicator View.....
    
    func addRemoveActivity(add: Bool, loadMessage: String){
        
        if add {
            
            let dimmerView: UIView = {
                let dim = UIView()
                dim.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                dim.translatesAutoresizingMaskIntoConstraints = false
                dim.alpha = 0
                return dim
            }()
            
            
            
            
            let container: UIView = {
                let cont = UIView()
                cont.translatesAutoresizingMaskIntoConstraints = false
                cont.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                cont.layer.cornerRadius = 10
                return cont
            }()
            
            let label: UILabel = {
                let lab = UILabel()
                lab.text = loadMessage
                lab.translatesAutoresizingMaskIntoConstraints = false
                lab.font = UIFont.boldSystemFont(ofSize: 15)
                lab.textAlignment = .center
                lab.textColor = .white
                return lab
            }()
            
            activityView.startAnimating()
            
            container.addSubview(label)
            container.addSubview(self.activityView)
            dimmerView.addSubview(container)
            self.view.addSubview(dimmerView)
            
            // add constraints...
            
            dimmerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            dimmerView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            dimmerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            dimmerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
  
            container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            container.widthAnchor.constraint(equalToConstant: 100).isActive = true
            container.heightAnchor.constraint(equalToConstant: 120).isActive = true
            
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
            label.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            self.activityView.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 30).isActive = true
            self.activityView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            
            UIView.animate(withDuration: 0.3) {
                dimmerView.alpha = 1
            }
            view.isUserInteractionEnabled = false
            
        } else {
            let dimmerSuperView = self.activityView.superview!.superview!
            UIView.animate(withDuration: 0.3, animations: {
                dimmerSuperView.alpha = 0
            }) { (true) in
                dimmerSuperView.removeFromSuperview()
                self.activityView.stopAnimating()
                self.view.isUserInteractionEnabled = true
                
            }
        }
        
    }
    
    
}

