//
//  UITextField.swift
//  Healo
//
//  Created by Elvina Jacia on 09/10/22.
//

import Foundation
import UIKit

extension SetProfileVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.selectedTextRange = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension UITextField{

      func addDoneButtonOnKeyboard(){

          let doneTFToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
          doneTFToolbar.barStyle = .default
          doneTFToolbar.isTranslucent = false
          doneTFToolbar.barTintColor = .pickerToolColor
          doneTFToolbar.layer.borderColor = UIColor.pickerBorder.cgColor
          doneTFToolbar.layer.borderWidth = 1
          
          let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
          done.tintColor = UIColor.darkPurple
          let items = [flexSpace, done]
          doneTFToolbar.items = items
          doneTFToolbar.sizeToFit()

          self.inputAccessoryView = doneTFToolbar

      }

     @objc func doneButtonAction() {
        self.resignFirstResponder()
         
     }


}
