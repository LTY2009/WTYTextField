//
//  WTYTextField.swift
//  WTYTextField
//
//  Created by LTY on 2019/4/23.
//

import UIKit

class WTYTextField: UITextField {
    
    private let bottomLine : CALayer = {
        let line = CALayer()
        line.backgroundColor = UIColor.x4FB0FF.cgColor
        line.isHidden = true
        return line
    }()
    
    private var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        return imageView
    }()
    
    public let label : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.x333333_alpha40
        label.textAlignment = .left
        label.frame = CGRect(x: 30, y: 0, width: 100, height: 30)
        return label
    }()
    
    //输入框文本颜色
    public var iconName: String! {
        didSet {
            self.iconImage.image = UIImage(named:iconName)
        }
    }
    
    
    /// init方法
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - isSecure: 是否是密码格式
    init(frame:CGRect,isSecure:Bool) {
        super.init(frame:frame)
        self.isSecureTextEntry = isSecure
        drawMyView()
        /// 添加字数判断
        addChangeTextTarget()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawMyView() {
        self.addSubview(iconImage)
        self.addSubview(label)
        self.layer.addSublayer(bottomLine)
        if self.isSecureTextEntry {
            let passwordSwitch = PassowrdSwitch(frame: CGRect(x: 0, y: 0, width: 21, height: 12.5))
            passwordSwitch.addTarget(self, action: #selector(togglePasswordHidden(sender:)), for: .touchUpInside)
            self.rightView = passwordSwitch
            self.rightViewMode = .always
        }
    }
    
    @objc func togglePasswordHidden(sender:PassowrdSwitch) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    /// 将placeholder上移方法,点击空的textfield时调用
    public func changeLabel() {
        UIView.animate(withDuration: 0.4) {
            self.label.frame = CGRect(x: 15, y: -20, width: 100, height: 20)
            self.label.font = UIFont.systemFont(ofSize: 10)
            self.label.textColor = UIColor.x4FB0FF
            self.iconImage.frame = CGRect(x: 0, y: -15, width: 10, height: 10)
            self.iconImage.image = UIImage(named:self.iconName)?.tintColor(color: UIColor.x4FB0FF)
        }
    }
    public func changeLineHidden() {
        self.bottomLine.isHidden = !self.bottomLine.isHidden
    }
    
    /// placeholder下移方法,当文字清空时调用
    public func disChangeLabel() {
        UIView.animate(withDuration: 0.4) {
            self.label.frame = CGRect(x: 30, y: 0, width: 100, height: self.frame.size.height)
            self.label.font = UIFont.systemFont(ofSize: 15)
            self.label.textColor = UIColor.x333333_alpha40
            self.iconImage.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
            self.iconImage.image = UIImage(named:self.iconName)?.tintColor(color: UIColor.x333333_alpha40)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let lineHeight = 1 / UIScreen.main.scale
        bottomLine.frame = CGRect(x: -6, y: self.bounds.height+3 - lineHeight, width: self.bounds.width+12, height: lineHeight)
    }
    
    /*
     * 重写方法调整rightView.frame来实现密码状态下的眼睛按钮与非密码状态下的清空按钮对齐
     * - Parameter bounds: textField.frame
     * - Returns: rightView.frame
     */
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 4
        return rect
    }
}


/*
 * 密码形式的右侧明密文转换按钮
 */
class PassowrdSwitch : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    func config() {
        self.setImage(UIImage(named:"TextField_password"), for: .normal)
        self.setImage(UIImage(named:"TextField_password_select"), for: .selected)
    }
}

