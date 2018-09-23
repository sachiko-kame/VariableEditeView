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
    
    var activeKeyBordHeight:CGFloat = 0
    var nowlineNum:CGFloat = 0
    let maxLine:CGFloat = 4 //-1した数がまで隠れず書ける

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        var editeViewHeight:CGFloat = 0
    
        if(self.nowlineNum > maxLine){
            editeViewHeight = self.maxVariableEditeViewHeight()
            self.variableEditeView.editTextView.isScrollEnabled = true
        }else{
            editeViewHeight = self.nowEditeViewHeight()
            self.variableEditeView.editTextView.isScrollEnabled = false
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.variableEditeView.frame.origin.y = self.ViewFrame.size.height - editeViewHeight - self.activeKeyBordHeight
            self.variableEditeView.frame.size.height = editeViewHeight
        },completion:nil)
        
    }
    
    func maxVariableEditeViewHeight() -> CGFloat {
        let maxEditTextViewlineHeight:CGFloat = (self.variableEditeView.editTextView.font?.lineHeight)! * maxLine
        let VariableEditeViewHeight:CGFloat = self.variableEditeView.nowAllHeight(editTextVieHeight:maxEditTextViewlineHeight)
        return VariableEditeViewHeight
    }
    
    func nowEditeViewHeight() -> CGFloat {
        let height = self.variableEditeView.editTextView.sizeThatFits(CGSize(width: self.variableEditeView.editTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        let VariableEditeViewHeight:CGFloat = self.variableEditeView.nowAllHeight(editTextVieHeight:height)
        return VariableEditeViewHeight
    }
}


extension ViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
       
        self.variableEditeView.editTextView.isScrollEnabled = true
        let textViewNumLines = textView.contentSize.height / (textView.font?.lineHeight)!
        self.nowlineNum = floor(textViewNumLines)
        
        if(self.nowlineNum > maxLine){
            self.variableEditeView.editTextView.isScrollEnabled = true
        }else{
            variableEditeView.editTextView.isScrollEnabled = false
            self.variableEditeView.frame.origin.y = ViewFrame.size.height - nowEditeViewHeight() - self.activeKeyBordHeight
            self.variableEditeView.frame.size.height = nowEditeViewHeight()
        }
    }
}

