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
    @IBAction func skipButtonTapped(_ sender: Any) {
        let landingVC = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController")
        self.navigationController?.viewControllers = [landingVC!]
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
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
