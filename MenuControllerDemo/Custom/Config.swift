//
//  Config.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.size.width
let screenH = UIScreen.main.bounds.size.height
let keyWindow = UIApplication.shared.keyWindow
let isIphoneX : Bool = screenH == 812.0 ? true : false
let kStatusBarH : CGFloat = isIphoneX == true ? 44 : 20

class Helper: NSObject {
    
    public class func getLabelHeight(text:String,font:CGFloat,width:CGFloat) -> CGFloat {
        
        let paraStyle = NSMutableParagraphStyle.init()
        let paraDic = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: font),NSAttributedStringKey.paragraphStyle:paraStyle]

        let size = text.boundingRect(with: CGSize(width:width,height:UIScreen.main.bounds.size.height), options: .usesLineFragmentOrigin, attributes: paraDic, context: nil)
        return size.height;
    }
}

extension Notification.Name {
    
    /// menu将隐藏的通知
    static let MenuWillHideNoti = Notification.Name(rawValue: "MenuWillHideNoti")

}
