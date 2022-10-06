//
//  ReusableNextButton.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 06/10/22.
//

import UIKit

class ReusableNextButton: UIButton {
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
        self.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        self.backgroundColor = .darkPurple
        self.layer.cornerRadius = 15
    }
}
