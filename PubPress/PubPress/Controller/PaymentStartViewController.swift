//
//  PaymentStartViewController.swift
//  PubPress
//
//  Created by Zhuxian on 4/30/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import Stripe

class PaymentStartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PaymentStartViewController: STPAddCardViewControllerDelegate
{
    
    func buyButtonTapped() {
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        // STPAddCardViewController must be shown inside a UINavigationController.
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        self.present(navigationController, animated: true, completion: nil)
    }

    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        /*self.submitTokenToBackend(token, completion: { (error: Error?) in
            if let error = error {
                completion(error)
            } else {
                self.dismiss(animated: true, completion: {
                    self.showReceiptPage()
                    completion(nil)
                })
            }
        })*/
    }
    
}
