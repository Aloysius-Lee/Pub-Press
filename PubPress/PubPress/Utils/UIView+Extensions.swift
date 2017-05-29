//
//  UIView+ViewController.swift
//  design
//
//  Created by Big Shark on 01/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}



extension UIImageView{
    
    
    func setImageWith(color: UIColor)
    {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    /*
    
    func setImageWith(storageRefString: String, placeholderImage: UIImage)
    {
        if storageRefString == ""
        {
            image = placeholderImage
        }
        else if storageRefString.hasPrefix("https://fb")
        {
            self.sd_setImage(with: URL(string: storageRefString), placeholderImage: placeholderImage)
        }
        else{
            let reference : FIRStorageReference = FIRStorage.storage().reference(forURL: storageRefString)
            self.sd_setImage(with: reference, placeholderImage: placeholderImage)
        }
        
    }*/
    
    
}


extension UITextField {
	
	public func shouldChangeValue(cardNumberBuffer : String){
		let  kAcceptSDKDemoCreditCardLengthPlusSpaces:Int = (TextFieldManager.shared.style.kAcceptSDKDemoCreditCardLength + 3)
		let kAcceptSDKDemoCreditCardObscureLength:Int = (TextFieldManager.shared.style.kAcceptSDKDemoCreditCardLength - 4)
		
		var value = String()
		
		let length = cardNumberBuffer.characters.count
		
		for (i, _) in cardNumberBuffer.characters.enumerated() {
			
			// Reveal only the last character.
			if (length <= kAcceptSDKDemoCreditCardObscureLength) {
				if (i == (length - 1)) {
					let charIndex = cardNumberBuffer.index(cardNumberBuffer.startIndex, offsetBy: i)
					let tempStr = String(cardNumberBuffer.characters.suffix(from: charIndex))
					//let singleCharacter = String(tempStr.characters.first)
					
					value = value + tempStr
				} else {
					value = value + TextFieldManager.shared.style.maskText
				}
			} else {
				if (i < kAcceptSDKDemoCreditCardObscureLength) {
					value = value + TextFieldManager.shared.style.maskText
				} else {
					let charIndex = cardNumberBuffer.index(cardNumberBuffer.startIndex, offsetBy: i)
					let tempStr = String(cardNumberBuffer.characters.suffix(from: charIndex))
					//let singleCharacter = String(tempStr.characters.first)
					//let singleCharacter = String(tempStr.characters.suffix(1))
					
					value = value + tempStr
					break
				}
			}
			
			//After 4 characters add a space
			if (((i + 1) % 4 == 0) && (value.characters.count < kAcceptSDKDemoCreditCardLengthPlusSpaces)) {
				value = value + TextFieldManager.shared.style.kAcceptSDKDemoSpace
			}
		}
		self.text = value
	}
}


// MARK: - TextField Style

/**
`ToastStyle` instances define the look and feel for toast views created via the
`makeToast` methods as well for toast views created directly with
`toastViewForMessage(message:title:image:style:)`.

@warning `ToastStyle` offers relatively simple styling options for the default
toast view. If you require a toast view with more complex UI, it probably makes more
sense to create your own custom UIView subclass and present it with the `showToast`
methods.
*/
public struct TextFieldStyle {
	
	public init() {}
	
	/**
	The mask text. Default is "●".
	*/
	public var maskText = "●"
	
	public var  kAcceptSDKDemoCreditCardLength:Int = 16
	public var  kAcceptSDKDemoExpirationLength:Int = 4
	public var  kAcceptSDKDemoExpirationMonthLength:Int = 2
	public var  kAcceptSDKDemoExpirationYearLength:Int = 2
	public var  kAcceptSDKDemoCVV2Length:Int = 4
	
	public var  kAcceptSDKDemoSpace:String = " "
	public var  kAcceptSDKDemoSlash:String = "/"
	
}

// MARK: - TextField Manager

/**
`TextFieldManager` provides general configuration options for all TextField.
*/
public class TextFieldManager {
	
	/**
	The `ToastManager` singleton instance.
	*/
	public static let shared = TextFieldManager()
	
	/**
	The shared style. Used whenever toastViewForMessage(message:title:image:style:) is called
	with with a nil style.
	*/
	public var style = TextFieldStyle()
}

