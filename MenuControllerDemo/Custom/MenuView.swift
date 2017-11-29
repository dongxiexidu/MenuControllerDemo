//
//  MenuView.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import SnapKit

struct MenuItemType : OptionSet {
    
    public var rawValue = 0  // 因为RawRepresentable的要求
    public static var copys = MenuItemType(rawValue : 1 << 0)

    public static var transmit = MenuItemType(rawValue : 1 << 1)

    public static var collect = MenuItemType(rawValue : 1 << 2)

    public static var delete = MenuItemType(rawValue : 1 << 3)

    public static var revoke = MenuItemType(rawValue : 1 << 4)

    public static var download = MenuItemType(rawValue : 1 << 5)
}

@objc protocol MenuViewDelegate : NSObjectProtocol {
   @objc optional func menuToThumbup()
   @objc optional func menuToCopy()
   @objc optional func menutoDelete()
   @objc optional func menuToTransmit()
   @objc optional func menuToDowanload()
   @objc optional func menuToPreview()
}

class MenuView: UIView {
    var itemType : MenuItemType? {
        didSet{
            guard let itemType = itemType else {
                return
            }
            backgroundImageView.addSubview(containerView)
            containerView.snp.makeConstraints { (make) in
                make.leading.trailing.bottom.equalTo(backgroundImageView)
                make.top.equalTo(backgroundImageView).offset(8)
            }

            if itemType.contains(.copys) && itemType.contains(.transmit) && itemType.contains(.collect) && itemType.contains(.delete) && itemType.contains(.revoke){
                itemCount = 5
                containerView.addArrangedSubview(copyingButton)
                containerView.addArrangedSubview(transmitButton)
                containerView.addArrangedSubview(collectButton)
                containerView.addArrangedSubview(revokeButton)
                containerView.addArrangedSubview(deleteButton)
            }else if itemType.contains(.copys) && itemType.contains(.transmit) && itemType.contains(.collect) && itemType.contains(.delete){
                itemCount = 4
                containerView.addArrangedSubview(copyingButton)
                containerView.addArrangedSubview(transmitButton)
                containerView.addArrangedSubview(collectButton)
                containerView.addArrangedSubview(deleteButton)
            }else {
                itemCount = 3
            }
            
        }
    }
    var itemCount : NSInteger = 0
    open weak var delegate : MenuViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(backgroundImageView)
        addSubview(arrowImageView)
    }
    
    lazy var backgroundImageView : UIImageView = {
        let backView = UIImageView()
        let bgImage = #imageLiteral(resourceName: "longpress_bg")
        backView.image = bgImage.stretchableImage(withLeftCapWidth: Int(bgImage.size.width * 0.5), topCapHeight: Int(bgImage.size.height * 0.5))
        backView.isUserInteractionEnabled = true
        return backView
    }()
    
    lazy var arrowImageView : UIImageView = {
        let arrowImageView = UIImageView()
        return arrowImageView
    }()
    
    lazy var containerView : UIStackView = {
        let containerView = UIStackView()
        containerView.alignment = .fill
        containerView.isUserInteractionEnabled = true
        return containerView
    }()
    lazy var revokeButton : UIButton = {
        let button =  creatButton(name: "撤回", image: #imageLiteral(resourceName: "revoke"))
        button.addTarget(self, action: #selector(thumbupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    func creatButton(name: String,image : UIImage) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImagePosition(position: .top, spacing: 3)
        return button
    }
    
    
    lazy var deleteButton : UIButton = {
        let button =  creatButton(name: "删除", image: #imageLiteral(resourceName: "delete"))
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var copyingButton : UIButton = {
        let button =  creatButton(name: "复制", image: #imageLiteral(resourceName: "copy"))
        button.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var transmitButton : UIButton = {
        let button =  creatButton(name: "转发", image: #imageLiteral(resourceName: "share"))
        button.addTarget(self, action: #selector(transmitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var downloadButton : UIButton = {
        let button =  creatButton(name: "下载", image: #imageLiteral(resourceName: "download"))
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var collectButton : UIButton = {
        let button =  creatButton(name: "收藏", image: #imageLiteral(resourceName: "favorite"))
        button.addTarget(self, action: #selector(previewButtonTapped), for: .touchUpInside)
        return button
    }()
    
}

// MARK: public method event response
extension MenuView {
   public func setTargetRect(targetRect: CGRect) {
    
        let itemW : CGFloat = 50
        let menuH : CGFloat = 58
        // 保证箭头在targetRect中心
        let targetCenterX : CGFloat = targetRect.origin.x + targetRect.size.width/2
        let menuW : CGFloat = CGFloat(itemCount) * itemW
        var menuX : CGFloat = targetCenterX - menuW/2 > 0 ? targetCenterX - menuW/2 : 0
        menuX = menuX + menuW > screenW ? screenW - menuW : menuX
        var menuY : CGFloat = targetRect.origin.y - menuH
        // 避免 MenuView 过于靠上
        menuY = menuY < kStatusBarH ? targetRect.origin.y + targetRect.size.height : menuY
        // 适配特别长的文本，直接显示在屏幕中间
        menuY = menuY > screenH-menuH-30 ? screenH / 2 : menuY
    
        
        self.frame = CGRect.init(x: menuX, y: menuY, width: menuW, height: menuH)
        
        let arrowH : CGFloat = 8
        let arrowW : CGFloat = 12
        let arrowX : CGFloat = targetRect.origin.x-frame.origin.x+0.5*targetRect.size.width-arrowW/2
        
        if frame.origin.y > targetRect.origin.y { // 箭头向上
            backgroundImageView.frame = CGRect.init(x: 0, y: arrowH, width: menuW, height: menuH-arrowH)
            arrowImageView.image = #imageLiteral(resourceName: "longpress_up_arrow")
            arrowImageView.frame = CGRect.init(x: arrowX, y: 0, width: arrowW, height: arrowH)
        }else{// 箭头向下
            backgroundImageView.frame = CGRect.init(x: 0, y: 0, width: menuW, height: menuH-arrowH)
            arrowImageView.image = #imageLiteral(resourceName: "longpress_down_arrow")
            arrowImageView.frame = CGRect.init(x: arrowX, y: menuH-arrowH, width: arrowW, height: arrowH)
        }
    }
}

// MARK: Private Method
extension MenuView {
    
    @objc func thumbupButtonTapped(){
        
        if let delegate = delegate,delegate.responds(to: #selector(delegate.menuToThumbup)) {
            delegate.menuToThumbup!()
        }
        self.removeFromSuperview()
    }
    
    @objc func deleteButtonTapped(){
        if let delegate = delegate,delegate.responds(to: #selector(delegate.menutoDelete)) {
            delegate.menutoDelete!()
        }
        self.removeFromSuperview()
    }
    
    @objc func copyButtonTapped(){
        if let delegate = delegate,delegate.responds(to: #selector(delegate.menuToCopy)) {
            delegate.menuToCopy!()
        }
        self.removeFromSuperview()
    }
    
    @objc func transmitButtonTapped(){
        if let delegate = delegate,delegate.responds(to: #selector(delegate.menuToTransmit)) {
            delegate.menuToTransmit!()
        }
        self.removeFromSuperview()
    }
    
    @objc func downloadButtonTapped(){
        if let delegate = delegate,delegate.responds(to: #selector(delegate.menuToDowanload)) {
            delegate.menuToDowanload!()
        }
        self.removeFromSuperview()
    }
    
    @objc func previewButtonTapped(){
        if let delegate = delegate,delegate.responds(to: #selector(delegate.menuToPreview)) {
            delegate.menuToPreview!()
        }
        self.removeFromSuperview()
    }
}
