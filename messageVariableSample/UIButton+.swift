//
//  UIButton+.swift
//  messageVariableSample
//
//  Created by 水野祥子 on 2018/09/23.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

extension UIButton{
    
    func decoration(text:String){
        self.setTitle(text, for: .normal)
        self.setTitleColor(.blue, for: .normal)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    
}
