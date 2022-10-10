//
//  SetProfileViewModel.swift
//  Healo
//
//  Created by Elvina Jacia on 09/10/22.
//

import UIKit
import RxSwift
import RxCocoa


class SetProfileViewModel {

    var tahunNow = Int(Calendar.current.component(.year, from: Date()))
    var tahunPast : Int {
        tahunNow - 50
    }
    
    var tahunList = [String]()
    var genderList = [String]()
  
    func setupTahunPicker(){
        tahunList.append("Tahun Lahir")
        var tahunAdd = tahunPast
        for i in 1...50 {
            tahunAdd += 1
            tahunList.append(String(tahunAdd))
        }
        
    }
    
    func setupGenderPicker(){
        genderList = ["Jenis Kelamin", "Pria", "Wanita"]
    }
    

    
}
