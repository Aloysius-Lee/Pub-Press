//
//  AddCardViewController.swift
//  PubPress
//
//  Created by Quan Zhuxian on 22/05/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

let kAcceptSDKDemoCreditCardLength:Int = 16
let kAcceptSDKDemoCreditCardLengthPlusSpaces:Int = (kAcceptSDKDemoCreditCardLength + 3)


class AddCardViewController: BaseViewController {

	var cardNumberBuffer : String = ""
	
	var status = 0
	@IBOutlet weak var skipButton: UIButton!
	@IBOutlet weak var backButton: UIButton!
	
	@IBOutlet weak var cardnoTextField: UITextField!
	@IBOutlet weak var countryTextField: UITextField!
	@IBOutlet weak var routingTextField: UITextField!
	@IBOutlet weak var yearTextField: UITextField!
	@IBOutlet weak var monthTextField: UITextField!
	@IBOutlet weak var dayTextField: UITextField!
	@IBOutlet weak var firstnameTextField: UITextField!
	@IBOutlet weak var lastnameTextField: UITextField!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var line1TextField: UITextField!
	@IBOutlet weak var postalCodeTextField: UITextField!
	@IBOutlet weak var stateTextField: UITextField!
	@IBOutlet weak var last4ssnTextField: UITextField!
	
	
	var pub: PubModel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		if status == Constants.ADDCARD_VIEW_REGISTER {
			skipButton.isHidden = false
			
		}
		else if status == Constants.ADDCARD_VIEW_MAIN{
			skipButton.isHidden = true
			backButton.isHidden = false
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be 
		
    }
	
	@IBAction func skipButtonTapped(_ sender: Any) {
		gotoMainScene()
	}
	
	
	
	func isMaxLength(_ textField:UITextField) -> Bool {
		var result = false
		
		if ((textField.text?.characters.count)! > kAcceptSDKDemoCreditCardLengthPlusSpaces)
		{
			result = true
		}
		
		return result
	}

	@IBAction func addCardButtonTapped(_ sender: Any) {
        let message = checkValid()
		if message == Constants.PROCESS_SUCCESS {
			ApiFunctions.accountCreate(pub, completion: {
				message in
				if message == Constants.PROCESS_SUCCESS {
					ApiFunctions.accountUpdate(self.pub, completion: {
						message in
						if message == Constants.PROCESS_SUCCESS {
							
							currentPub = self.pub
							self.gotoMainScene()
						}
						else {
							self.showToastWithDuration(string: message, duration: 3.0)
						}
					})
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
	
	@IBAction func tableViewTapped(_ sender: Any) {
		self.view.endEditing(true)
	}
	
	func checkValid() -> String{
		if cardNumberBuffer.characters.count != kAcceptSDKDemoCreditCardLength {
			return Constants.CHECK_CARDNO_ERROR
		}
		else if countryTextField.text?.characters.count == 0{
			return Constants.CHECK_COUNTRY_ERROR
		}
		else if routingTextField.text == "" {
			return Constants.CHECK_ROUTING_EMPTY
		}
		else if yearTextField.text?.characters.count == 0 || monthTextField.text?.characters.count == 0 || dayTextField.text?.characters.count == 0 {
			return Constants.CHECK_DOB_ERROR
		}
		else if firstnameTextField.text?.characters.count == 0 {
			return Constants.CHECK_FIRSTNAME_EMPTY
		}
        else if lastnameTextField.text?.characters.count == 0 {
            return Constants.CHECK_LASTNAME_EMPTY
        }
        else if cityTextField.text?.characters.count == 0 {
            return Constants.CHECK_CITY_EMPTY
        }
        else if line1TextField.text?.characters.count == 0 {
            return Constants.CHECK_LINE1_EMPTY
        }
        else if postalCodeTextField.text?.characters.count == 0 {
            return Constants.CHECK_POSTALCODE_EMPTY
        }
        else if stateTextField.text?.characters.count == 0 {
            return Constants.CHECK_STATE_EMPTY
        }
        else if last4ssnTextField.text?.characters.count == 0 {
            return Constants.CHECK_SSNLAST4_ERROR
        }
        
        let bankAccount = pub.pub_bankaccount
        bankAccount.acc_number = cardNumberBuffer
        bankAccount.acc_country = countryTextField.text!
        bankAccount.acc_routing = routingTextField.text!
        bankAccount.dob_year = yearTextField.text!
        bankAccount.dob_month = monthTextField.text!
        bankAccount.dob_day = dayTextField.text!
        bankAccount.first_name = firstnameTextField.text!
        bankAccount.last_name = lastnameTextField.text!
        bankAccount.city = cityTextField.text!
        bankAccount.line1 = line1TextField.text!
        bankAccount.postal_code = postalCodeTextField.text!
        bankAccount.state = stateTextField.text!
        bankAccount.ssn_last_4 = last4ssnTextField.text!
        
		
		return Constants.PROCESS_SUCCESS
	}
}

extension AddCardViewController : UITextFieldDelegate {

	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == cardnoTextField {
			if (string.characters.count > 0)
			{
				if (self.isMaxLength(textField)) {
					
					return false
				}
				
				self.cardNumberBuffer = String(format: "%@%@", self.cardNumberBuffer, string)
			}
			else
			{
				if (self.cardNumberBuffer.characters.count > 1)
				{
					let length = self.cardNumberBuffer.characters.count-1
					self.cardNumberBuffer = self.cardNumberBuffer[self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: 0)...self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: length-1)]
				}
				else
				{
					self.cardNumberBuffer = ""
				}
			}
			NSLog("card number = \(self.cardNumberBuffer)")
			textField.shouldChangeValue(cardNumberBuffer: self.cardNumberBuffer)
            
            return false
		}
        else {
            return true
        }
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == routingTextField {
			yearTextField.becomeFirstResponder()
		}
		else if textField == firstnameTextField {
			lastnameTextField.becomeFirstResponder()
		}
		else if textField == lastnameTextField {
			cityTextField.becomeFirstResponder()
		}
		else if textField == cityTextField {
			line1TextField.becomeFirstResponder()
		}
		else if textField == line1TextField {
			postalCodeTextField.becomeFirstResponder()
		}
		else if textField == postalCodeTextField {
			stateTextField.becomeFirstResponder()
		}
		else if textField == stateTextField {
			last4ssnTextField.becomeFirstResponder()
		}
		else if textField == last4ssnTextField {
			self.view.endEditing(true)
			addCardButtonTapped("")
		}
		
		textField.resignFirstResponder()
		return true
	}
	
	
	
	
	
}
