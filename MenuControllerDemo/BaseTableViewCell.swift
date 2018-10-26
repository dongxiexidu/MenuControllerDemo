//
//  BaseTableViewCell.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit


enum MessageAlignement {
    case undefined
    case left
    case right
}
let kAvatarSize : CGFloat = 45
let kAvatarMarginH : CGFloat = 10

class BaseTableViewCell: UITableViewCell {

    var alignement : MessageAlignement = .left
    var bubbleView : UIImageView!
    
    var message : Message? {
        didSet {
            guard let message = message else {
                return
            }
            
            let imageName = message.msgDirection == .incoming ? DXAsset.liuyifei_icon.image : DXAsset.xiaohuangren_icon.image
            avatarHeaderView.image = imageName
        }
    }
    /// 头像
    var avatarHeaderView : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        alignement = reuseIdentifier?.contains(kCellIdentifierLeft) == true ? .left : .right
        buildCell()
        bindGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var customMenu: MenuView = {
        let menu = MenuView.init(frame: CGRect.zero)
        menu.delegate = self
        return menu
    }()
    
    func buildCell() {
        contentView.backgroundColor = UIColor.init(white: 241.0/255.0, alpha: 1)
        selectionStyle = .none
        
        bubbleView = UIImageView.init()
        bubbleView.isUserInteractionEnabled = true
        contentView.addSubview(bubbleView)
        
        avatarHeaderView = UIImageView.init()
        avatarHeaderView.backgroundColor = UIColor.red
        avatarHeaderView.layer.cornerRadius = CGFloat(kAvatarSize)/CGFloat(2)
        avatarHeaderView.layer.masksToBounds = true
        contentView.addSubview(avatarHeaderView)
        
        if alignement == .left {
            let bubbleImage = DXAsset.qq_bubble_b_icon.image
            bubbleView.image = bubbleImage.stretchableImage(withLeftCapWidth: 20, topCapHeight: 15)
            avatarHeaderView.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.width.height.equalTo(kAvatarSize)
                make.leading.equalToSuperview().offset(kAvatarMarginH)
            })
            
            bubbleView.snp.makeConstraints({ (make) in
                make.width.lessThanOrEqualToSuperview()
                make.left.equalToSuperview().offset(kAvatarSize + 18)
                make.top.equalTo(contentView)
                make.right.lessThanOrEqualTo(contentView).offset(-73)
                make.bottom.equalTo(contentView).offset(-20).priority(.low)
            })
            
        }else{
            let bubbleImage = DXAsset.qq_bubble_a_icon.image
            bubbleView.image = bubbleImage.stretchableImage(withLeftCapWidth: 14, topCapHeight: 15)
            
            avatarHeaderView.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.width.height.equalTo(kAvatarSize)
                make.trailing.equalToSuperview().offset(-kAvatarMarginH)
            })
            
            bubbleView.snp.makeConstraints({ (make) in
                make.width.lessThanOrEqualToSuperview()
                make.top.equalTo(contentView)
                make.right.equalTo(contentView).offset(-kAvatarSize - 18)
                make.left.greaterThanOrEqualToSuperview().offset(73)
                make.bottom.equalTo(contentView).offset(-20).priority(.low)
            })
        }
    }

    func bindGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressOnBubble(gesture:)))
        bubbleView.addGestureRecognizer(longPress)
    }
    @objc func hideMenuNotiAction() {
        customMenu.removeFromSuperview()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Private Method
extension BaseTableViewCell {
    @objc func longPressOnBubble(gesture : UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
        if message?.msgDirection == .incoming {
            customMenu.itemType = [.copys,.transmit,.collect,.delete]
        }else{
           // customMenu.itemType = [.copys,.transmit,.collect,.revoke,.delete]
            customMenu.itemType = .allCase
        }
            
            NotificationCenter.default.post(name: NSNotification.Name.MenuWillHideNoti, object: nil)
            keyWindow?.addSubview(customMenu)
            // 计算frame封装在控件内部，使用的时候只要传一个 targetRect 参数即可
            let targetRectInWindow = contentView.convert(bubbleView.frame, to: keyWindow)
            customMenu.setTargetRect(targetRect: targetRectInWindow)
            NotificationCenter.default.addObserver(self, selector: #selector(hideMenuNotiAction), name: NSNotification.Name.MenuWillHideNoti, object: nil)
        }
    }
}

extension BaseTableViewCell: MenuViewDelegate {
    func menuToThumbup() {
        print("menuToThumbupTapped")
    }
//    func menuToCopy() {
//        print("menuToCopy")
//    }
//    func menutoDelete() {
//        print("menutoDelete")
//    }
//
//    func menuToPreview() {
//        print("menuToPreview")
//    }
//
//    func menuToTransmit() {
//        print("menuToTransmit")
//    }
//
//    func menuToDowanload() {
//        print("menuToDowanload")
//    }
    
}
