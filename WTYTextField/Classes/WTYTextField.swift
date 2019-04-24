//
//  WTYTextField.swift
//  WTYTextField
//
//  Created by LTY on 2019/4/23.
//

import UIKit

open class WTYTextField: UITextField {
    
    // 默认色
    public var defaultColor: UIColor! = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.4) {
        didSet {
            self.label.textColor = defaultColor
        }
    }
    
    // 选中色
    public var seletColor: UIColor! = UIColor(red: 79/255, green: 176/255, blue: 255/255, alpha: 1) {
        didSet {
            self.bottomLine.backgroundColor = seletColor.cgColor
        }
    }
    
    // 图片名
    public var iconName: String! {
        didSet {
            self.iconImage.image = UIImage(named:iconName)
        }
    }
    
    private let bottomLine : CALayer = {
        let line = CALayer()
        line.isHidden = true
        return line
    }()
    
    private var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        return imageView
    }()
    
    public var label : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.frame = CGRect(x: 30, y: 0, width: 100, height: 30)
        return label
    }()
    
    
    /*
     * init方法
     * - Parameters:
     * - frame: frame
     * - isSecure: 是否是密码格式
     */
    public init(frame:CGRect,isSecure:Bool) {
        super.init(frame:frame)
        self.isSecureTextEntry = isSecure
        drawMyView()
        /// 添加字数判断
        addChangeTextTarget()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawMyView() {
        self.addSubview(iconImage)
        label.textColor = defaultColor
        self.addSubview(label)
        bottomLine.backgroundColor = seletColor.cgColor
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
    
    /*
     * 将placeholder上移方法,点击空的textfield时调用
     */
    public func changeLabel() {
        UIView.animate(withDuration: 0.4) {
            self.label.frame = CGRect(x: 15, y: -20, width: 100, height: 20)
            self.label.font = UIFont.systemFont(ofSize: 10)
            self.label.textColor = self.seletColor
            self.iconImage.frame = CGRect(x: 0, y: -15, width: 10, height: 10)
            self.iconImage.image = UIImage(named:self.iconName)?.tintColor(color: self.seletColor)
        }
    }
    
    public func changeLineHidden() {
        self.bottomLine.isHidden = !self.bottomLine.isHidden
    }
    
    /*
     * placeholder下移方法,当文字清空时调用
     */
    public func disChangeLabel() {
        UIView.animate(withDuration: 0.4) {
            self.label.frame = CGRect(x: 30, y: 0, width: 100, height: self.frame.size.height)
            self.label.font = UIFont.systemFont(ofSize: 15)
            self.label.textColor = self.defaultColor
            self.iconImage.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
            self.iconImage.image = UIImage(named:self.iconName)?.tintColor(color: self.defaultColor)
        }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        let lineHeight = 1 / UIScreen.main.scale
        bottomLine.frame = CGRect(x: -6, y: self.bounds.height+3 - lineHeight, width: self.bounds.width+12, height: lineHeight)
    }
    
    /*
     * 重写方法调整rightView.frame来实现密码状态下的眼睛按钮与非密码状态下的清空按钮对齐
     * - Parameter bounds: textField.frame
     * - Returns: rightView.frame
     */
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
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
        let imageBundle = Bundle.init(url: Bundle(for: object_getClass(self)!).url(forResource: "WTYTextField", withExtension: "bundle")!)
        
        self.setImage(UIImage(named: "close_eye", in: imageBundle, compatibleWith: nil), for: .normal)
        self.setImage(UIImage(named: "open_eye", in: imageBundle, compatibleWith: nil), for: .selected)
    }
}

