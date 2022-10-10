//
//  UIImageView.swift
//  Healo
//
//  Created by Elvina Jacia on 09/10/22.
//

import UIKit

extension UIImageView {
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
