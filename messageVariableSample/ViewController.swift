//
//  ViewController.swift
//  messageVariableSample
//
//  Created by 水野祥子 on 2018/09/23.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ViewFrame:CGRect = UIScreen.main.bounds
    var variableEditeView:VariableEditeView!
    
    var firstaddCardEditeViewY:CGFloat{
        return ViewFrame.size.height - VariableEditeView.height
    }
    
    /*
     現在のKeyBordの高さの保持
     */
    var activeKeyBordHeight:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         一番下に来るようにSet
         */
        variableEditeView = VariableEditeView(frame: CGRect(x: 0, y: firstaddCardEditeViewY, width: ViewFrame.size.width, height: VariableEditeView.height))
        
        variableEditeView.editTextView.delegate = self
        
        self.view.addSubview(variableEditeView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func handleKeyboardWillHideNotification(_ notification: Notification){
        print("キーボード非表示")
        self.activeKeyBordHeight = 0
        self.variableEditeView.editTextView.isScrollEnabled = false
        self.variableEditeView.frame.origin.y = firstaddCardEditeViewY
        self.variableEditeView.frame.size.height = VariableEditeView.height
    }
    
    @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
        print("キーボード表示")
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.activeKeyBordHeight = keyboardScreenEndFrame.height
        let duration:TimeInterval = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        let height = self.variableEditeView.editTextView.sizeThatFits(CGSize(width: self.variableEditeView.editTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        
        let CardEditeViewHeight = self.variableEditeView.nowOverallHeight(editTextVieHeight:height)
        
        UIView.animate(withDuration: duration, animations: {
            self.variableEditeView.frame.origin.y = self.ViewFrame.size.height - CardEditeViewHeight - keyboardScreenEndFrame.height
            self.variableEditeView.frame.size.height = CardEditeViewHeight
        },completion:nil)
        
    }
}


extension ViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
        let height = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        let variableEditeViewHeight = variableEditeView.nowOverallHeight(editTextVieHeight:height)
        let textViewNumLines = textView.contentSize.height / (textView.font?.lineHeight)!
        
        if(textViewNumLines > 4){
            self.variableEditeView.editTextView.isScrollEnabled = true
        }else{
            variableEditeView.editTextView.isScrollEnabled = false
            self.variableEditeView.frame.origin.y = ViewFrame.size.height - variableEditeViewHeight - self.activeKeyBordHeight
            self.variableEditeView.frame.size.height = variableEditeViewHeight
        }
    }
}

