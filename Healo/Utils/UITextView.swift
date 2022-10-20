//
//  UITextView.swift
//  Healo
//
//  Created by Elvina Jacia on 19/10/22.
//

import Foundation
import UIKit

extension CriteriaVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if topicField.text == "Contoh: Hari ini saya merasa \ninsecure karena suatu hal yang \ndikatakan oleh orang tua saya." {
            topicField.text = ""
        }
        topicField.textColor = UIColor.blackPurple
        setupKeyboard()
        return
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            topicField.text = "Contoh: Hari ini saya merasa \ninsecure karena suatu hal yang \ndikatakan oleh orang tua saya."
            topicField.textColor = .tabBarGreyPurple
            self.validateAll()
        } else {
            self.validateAll()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let curText = textView.text ?? ""
        guard let stringRange = Range(range, in: curText) else { return false }
        let upText = curText.replacingCharacters(in: stringRange, with: text)
        return upText.count <= 150
    }
    
}

extension UITextView{

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

