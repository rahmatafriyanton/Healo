//
//  UserConditionsViewController.swift
//  Healo
//
//  Created by Vincentius Ian Widi Nugroho on 04/10/22.
//

import UIKit

class UserConditionsViewController: UIViewController {
    var checked: Int = 0
    
    private lazy var checkBox: UIButton = {
       let view = UIButton()
        let normalImage = UIImage(systemName: "square")?.withTintColor(.darkPurple, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "checkmark.square.fill")?.withTintColor(.darkPurple, renderingMode: .alwaysOriginal)
        view.setImage(normalImage, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        return view
    }()
    
    @objc func toggleCheck() {
        print("button pressed")
        if(checkBox.isSelected) {
            checkBox.isSelected = false
        } else {
            checkBox.isSelected = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let dateFormatter = DateFormatter()
        let dateNow = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(dateFormatter.string(from: dateNow))
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38)
            make.bottom.equalToSuperview().offset(-218)
            make.height.width.equalTo(24)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
