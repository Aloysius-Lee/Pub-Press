//
//  AnimationTest.swift
//  PubPress
//
//  Created by Zhuxian on 4/15/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class AnimationTest: BaseViewController {

    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var animationViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        //animationViewHeightConstraint.constant = 0
        keyboardControl()
        
        animationView.frame = CGRect(x: 0, y: 100, width: 300, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
}

extension AnimationTest{
    
    //** Keyboard Show and Hide
    
    func keyboardControl() {
        /**
         Keyboard notifications
         */
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: true)
    }
    
    func keyboardWillHide(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: false)
    }
    
    
    func keyboardControl(_ notification: Notification, isShowing: Bool)
    {
        
        var userInfo = notification.userInfo!
        let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        
        //  let convertedFrame = self.view.convert(keyboardRect!, from: nil)
        //   let heightOffset = self.view.bounds.size.height - convertedFrame.origin.y
        let options = UIViewAnimationOptions(rawValue: UInt(curve!) << 16 | UIViewAnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue
        //duration!
        
        NSLog("duration == \(duration as! Double)")
        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                if isShowing{
                    self.animationView.frame.size.height = 300
                    
                }
                else
                {
                    
                    
                }
        },
            completion: { bool in
                if isShowing{
                   
                }
                else
                {
                    
                    
                }
                
                
        })
       
    }
    
    ///

}
