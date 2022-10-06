//
//  ReusableLabel.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 06/10/22.
//

import UIKit

class ReusableLabel: UILabel {
    
    enum labelTypeEnum {
        case title
        case body
    }
    
    public private(set) var labelText: String
    public private(set) var type: labelTypeEnum

    
    init(labelText: String, type: labelTypeEnum){
        self.labelText = labelText
        self.type = type
        
        super.init(frame: .zero)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel(){
        self.text = labelText
        self.numberOfLines = 0
        configureType()
    }
    
    private func configureType(){
        switch type {
        case .title:
            self.font = UIFont(name: "Poppins-SemiBold", size: 21.0)
        case .body:
            self.font = UIFont(name: "Poppins-Regular", size: 16.0)
        }
    }
}
