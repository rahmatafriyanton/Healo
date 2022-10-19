//
//  ReusableChoiceButton.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 18/10/22.
//

import UIKit

class ReusableChoiceButton: UIButton {

    public private(set) var text: String
    
    init(text: String){
        self.text = text
        
        super.init(frame: .zero)
        self.configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(){
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(.blackPurple, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.backgroundColor = .lightPurple
        self.layer.cornerRadius = 15
        
    }

}
