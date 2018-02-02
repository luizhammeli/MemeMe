//
//  CreateMemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Luiz Hammerli on 02/02/2018.
//  Copyright © 2018 Luiz Hammerli. All rights reserved.
//

import Foundation
import UIKit

class CreateMemeTextFieldDelegate: NSObject,UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text == Strings.topTextFieldDefaultText || textField.text == Strings.bottomTextFieldDefaultText ){
            textField.text?.removeAll()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
