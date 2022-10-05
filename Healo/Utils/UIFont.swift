//
//  UIFont.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 04/10/22.
//

import Foundation
import UIKit

extension UIFont {
    static func poppinsBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Bold", size: size)
    }

    static func poppinsSemiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-SemiBold", size: size)
    }

    static func poppinsRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Regular", size: size)
    }
}
