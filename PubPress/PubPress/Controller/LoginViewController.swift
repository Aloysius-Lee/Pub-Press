//
//  LoginViewController.swift
//  PubPress
//
//  Created by Quan Zhuxian on 09/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func skipButtonTapped(_ sender: Any) {
        let landingVC = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController")
        self.navigationController?.viewControllers = [landingVC!]
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let message = checkValid()
        
        if message == Constants.PROCESS_SUCCESS {
            showLoadingView()
            ApiFunctions.login(email: emailTextField.text!, password: passwordTextField.text!, completion: {
                message, object in
                self.hideLoadingView()
                if message == Constants.PROCESS_SUCCESS {
                    if object.isKind(of: UserModel.self) {
                        currentUser = object as! UserModel
                    }
                    else {
                        currentPub = object as! PubModel
                    }
                    
                    UserDefaults.standard.set(self.emailTextField.text!, forKey: Constants.KEY_EMAIL)
                    UserDefaults.standard.set(self.passwordTextField.text!, forKey: Constants.KEY_PASSWORD)
                    let rootVC = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController")
                    self.navigationController?.viewControllers = [rootVC!]
                }
                else {
                    self.showToastWithDuration(string: message, duration: 3.0)
                }
                
                
            })
        }
        else {
            showToastWithDuration(string: message, duration: 3.0)
        }
    }
    
    
    func checkValid() -> String {
        
        self.view.endEditing(true)
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if email.characters.count == 0 {
            return Constants.CHECK_EMAIL_EMPTY
        }
        if !CommonUtils.isValidEmail(email) {
            return Constants.CHECK_EMAIL_INVALID
        }
        if password.characters.count == 0 {
            return Constants.CHECK_PASSWORD_EMPTY
        }
        return Constants.PROCESS_SUCCESS
        
    }
}
