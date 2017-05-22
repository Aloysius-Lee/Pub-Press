//
//  RegisterUserViewController.swift
//  PubPress
//
//  Created by Quan Zhuxian on 09/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class RegisterUserViewController: BaseViewController {
    
    
    var object : AnyObject!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        if object.isKind(of: UserModel.self) {
            initUserRegisterUI()
        }
        else if object.isKind(of: PubModel.self) {
            initPubRegisterUI()
        }
    }
    
    func initUserRegisterUI() {
        fullnameLabel.text = "Full name:"
        nextButton.setTitle("register", for: .normal)
    }
    
    func initPubRegisterUI() {
        fullnameLabel.text = "Pub name:"
        nextButton.setTitle("next", for: .normal)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        let message = checkValid()
        if message == Constants.PROCESS_SUCCESS {
            if object.isKind(of: UserModel.self){
				self.showLoadingView()
                ApiFunctions.registerUser(object as! UserModel, completion: {
                    message, user in
					self.hideLoadingView()
                    if message == Constants.PROCESS_SUCCESS {
                        self.gotoMainScene()
                    }
                    else { 
                        self.showToastWithDuration(string: message, duration: 3.0)
                    }
                })
            }
            else if object.isKind(of: PubModel.self) {
				self.showLoadingView()
				ApiFunctions.checkEmailValid((object as! PubModel).pub_contactemail , completion: {
					message in
					self.hideLoadingView()
					if message == Constants.PROCESS_SUCCESS {
						let addPubVC = self.storyboard?.instantiateViewController(withIdentifier: "AddPubViewController") as! AddPubViewController
						addPubVC.pub = self.object as! PubModel
						
						self.navigationController?.pushViewController(addPubVC, animated: true)
					}
					else {
						self.showToastWithDuration(string: message, duration: 3.0)
					}
				})
				
            }
        }
        else {
            self.showToastWithDuration(string: message, duration: 3.0)
        }
    }
	
    func checkValid() -> String {
        
        self.view.endEditing(true)
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let name = fullnameTextField.text!
        if email.characters.count == 0 {
            return Constants.CHECK_EMAIL_EMPTY
        }
        if !CommonUtils.isValidEmail(email) {
            return Constants.CHECK_EMAIL_INVALID
        }
        if password.characters.count == 0 {
            return Constants.CHECK_PASSWORD_EMPTY
        }
        if name.characters.count == 0 {
            return Constants.CHECK_NAME_EMPTY
        }
        
        if object.isKind(of: UserModel.self) {
            (object as! UserModel).user_email = email
            (object as! UserModel).user_password = password
            (object as! UserModel).user_name = name
            
        }
        else if object.isKind(of: PubModel.self) {
            (object as! PubModel).pub_contactemail = email
            (object as! PubModel).pub_contactpassword = password
            (object as! PubModel).pub_name = name
        }
        
        return Constants.PROCESS_SUCCESS
        
    }
}
