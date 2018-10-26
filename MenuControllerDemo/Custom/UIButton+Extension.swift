//
//  UIButton+Extension.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

enum ImagePosition {
    case left
    case right
    case top
    case bottom
}

extension UIButton {
    
    /**
     *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
     *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
     *
     *  @param spacing 图片和文字的间隔
     */
     func setImagePosition(position : ImagePosition,spacing: CGFloat) {
        
        let imageWith : CGFloat = imageView!.image!.size.width
        let imageHeight : CGFloat = imageView!.image!.size.height
        let attrs = [NSAttributedString.Key.font:titleLabel!.font!]
        let labelWidth : CGFloat = titleLabel!.text!.size(withAttributes: attrs).width
        let labelHeight : CGFloat = titleLabel!.text!.size(withAttributes: attrs).height
        
        //image中心移动的x距离
        let imageOffsetX : CGFloat = (imageWith + labelWidth) / 2 - imageWith / 2
        //image中心移动的x距离
        let imageOffsetY : CGFloat = imageHeight / 2 + spacing / 2
        //label中心移动的x距离
        let labelOffsetX : CGFloat = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2
        //label中心移动的y距离
        let labelOffsetY : CGFloat = labelHeight / 2 + spacing / 2
        
        switch position {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + spacing/2, bottom: 0, right: -(labelWidth + spacing/2))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageHeight + spacing/2), bottom: 0, right: imageHeight + spacing/2)
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
        }
    }
}
