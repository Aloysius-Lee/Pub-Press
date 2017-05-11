//
//  StartViewController.swift
//  PubPress
//
//  Created by Quan Zhuxian on 09/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UserDefaults.standard.value(forKey: Constants.KEY_EMAIL) != nil {
            loginWithExistingAccount()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginWithExistingAccount() {
        let email = UserDefaults.standard.value(forKey: Constants.KEY_EMAIL) as! String
        let password = UserDefaults.standard.value(forKey: Constants.KEY_PASSWORD) as! String
        showLoadingView()
        ApiFunctions.login(email: email, password: password, completion: {
            message, object in
            self.hideLoadingView()
            if message == Constants.PROCESS_SUCCESS {
                if object.isKind(of: UserModel.self) {
                    currentUser = object as! UserModel
                }
                else {
                    currentPub = object as! PubModel
                }
                
                let rootVC = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController")
                self.navigationController?.viewControllers = [rootVC!]
            }
            else {
                self.showToastWithDuration(string: message, duration: 3.0)
            }
            
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func skipButtonTapped(_ sender: Any) {
        let landingVC = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController")
        self.navigationController?.viewControllers = [landingVC!]
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        if sender.tag == 101 {
            registerVC.object = PubModel() as AnyObject
        }
        else if sender.tag == 102 {
            registerVC.object = UserModel() as AnyObject
        }
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
