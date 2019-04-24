//
//  ViewController.swift
//  WTYTextField
//
//  Created by LTY on 04/23/2019.
//  Copyright (c) 2019 LTY. All rights reserved.
//

import UIKit
import WTYTextField

class ViewController: UIViewController {
    let phoneTF : WTYTextField = {
        let textField = WTYTextField(frame: CGRect(x: 24, y: 150, width: UIScreen.main.bounds.size.width - 48, height: 30), isSecure: false)
        textField.label.text = "帐号"
        textField.iconName = "login_urseIco"
        textField.seletColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.clearButtonMode = .always
        textField.maxTextNumber = 11
        textField.keyboardType = .phonePad
        return textField
    }()
    let passwordTF : WTYTextField = {
        let textField = WTYTextField(frame: CGRect(x: 24, y: 210, width: UIScreen.main.bounds.size.width - 48, height: 30), isSecure: true)
        textField.label.text = "密码"
        textField.iconName = "login_pwdIco"
        textField.maxTextNumber = 15
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(phoneTF)
        self.view.addSubview(passwordTF)
        phoneTF.delegate = self
        passwordTF.delegate = self
    }
    
    /// 点击任意位置取消第一响应,弹回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let textField = textField as? WTYTextField else {
            return true
        }
        if textField.text == ""{
            textField.changeLabel()
        }
        textField.changeLineHidden()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? WTYTextField else {
            return
        }
        if textField.text == "" {
            textField.disChangeLabel()
        }
        textField.changeLineHidden()
    }
}


