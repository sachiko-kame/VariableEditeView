//
//  VariableEditeView.swift
//  messageVariableSample
//
//  Created by 水野祥子 on 2018/09/23.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

/*
 image
 |  close  |  add  |
 ||   sampleText  ||
 */

class VariableEditeView: UIView {

    var closeButton:UIButton = UIButton()
    var addButton:UIButton = UIButton()
    var editTextView:UITextView = UITextView()
    
    let buttonHeight:CGFloat = 30
    let textViewPadding:CGFloat = 3
    let textViewTopPadding:CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        
        closeButton.decoration(text:"keybord close")
        closeButton.addTarget(self, action: #selector(keyBord_Close), for: .touchUpInside)
        
        
        addButton.decoration(text:"add")
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        
        editTextView.font =  UIFont.systemFont(ofSize: 13)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        editTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(closeButton)
        self.addSubview(addButton)
        self.addSubview(editTextView)
        
        closeButton.topAnchor.constraint(equalTo:self.topAnchor, constant: 0.0).isActive = true
        closeButton.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 0.0).isActive = true
        closeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        closeButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        addButton.leadingAnchor.constraint(equalTo:closeButton.trailingAnchor, constant: 0.0).isActive = true
        addButton.topAnchor.constraint(equalTo:self.topAnchor, constant: 0.0).isActive = true
        addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        editTextView.topAnchor.constraint(equalTo:addButton.bottomAnchor, constant: textViewPadding).isActive = true
        editTextView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: textViewPadding).isActive = true
        editTextView.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: textViewTopPadding).isActive = true
        
        editTextView.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: textViewTopPadding).isActive = true
        
    }
    
    func nowOverallHeight(editTextVieHeight:CGFloat) -> CGFloat{
        var TextVieHeight:CGFloat = editTextVieHeight
        if(TextVieHeight == 0){//初期
            TextVieHeight = self.frame.size.height - buttonHeight
        }
        let height:CGFloat = buttonHeight + TextVieHeight
        return height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let height:CGFloat = 70 //最初のみ
    
    @objc func add(){
        print("何か追加するボタン")
    }
    
    @objc func keyBord_Close(){
        print("keybord閉じるボタン")
        self.editTextView.resignFirstResponder()
    }
}
