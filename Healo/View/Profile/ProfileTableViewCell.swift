//
//  ProfileTableViewCell.swift
//  Healo
//
//  Created by Hana Salsabila on 21/10/22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    var iconImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .blackPurple
        return label
    }()
    var nextImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAll() {
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nextImage)
    }
    
    func configure(image: String, text: String) {
        iconImage.image = UIImage(systemName: image)
        titleLabel.text = text
        nextImage.image = UIImage(systemName: "chevron.right")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
        titleLabel.text = nil
        nextImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.frame = CGRect(x: 0, y: (contentView.frame.size.height-iconImage.frame.size.height)/2, width: 45, height: 45)
        titleLabel.frame = CGRect(x: 19 + iconImage.frame.size.width, y: 0, width: 95, height: contentView.frame.size.height)
        nextImage.frame = CGRect(x: contentView.frame.size.width - 60, y: (contentView.frame.size.height-nextImage.frame.size.height)/2, width: 12, height: 19)
    }

}
