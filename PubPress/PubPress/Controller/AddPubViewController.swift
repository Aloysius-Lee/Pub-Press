//
//  AddPubViewController.swift
//  PubPress
//
//  Created by Zhuxian on 5/1/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class AddPubViewController: BaseViewController {
    
    var pub: PubModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    


}
