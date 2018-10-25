//
//  UIImage+Asset.swift
//  FashionMall_ipad
//
//  Created by fashion on 2018/10/25.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import Foundation
import UIKit

typealias DXAsset = UIImage.Asset

extension UIImage {
    enum Asset : String {
        /// cell image底部 左侧气泡
        case qq_bubble_b_icon = "qq_bubble_b"
        /// cell image底部 右侧气泡
        case qq_bubble_a_icon = "qq_bubble_a"
        /// 长按icon
        case longpress_bg_icon  = "longpress_bg"
        
        /// 删除
        case delete_icon = "delete"
        
        /// copy
        case copy_icon = "copy"
        
        /// 转发
        case transmit_icon = "share"
        /// download
        case download_icon = "download"
        
        /// favorite
        case favorite_icon = "favorite"
        /// revoke
        case revoke_icon = "revoke"
        /// longpress_up
        case longpress_up_arrow_icon = "longpress_up_arrow"
        
        /// longpress_down
        case longpress_down_arrow_icon = "longpress_down_arrow"
        
        /// liuyifei
        case liuyifei_icon = "liuyifei"
        
        /// liuyifei
        case xiaohuangren_icon = "xiaohuangren"
        
        var image : UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init(asset: Asset) {
        self.init(named: asset.rawValue)!
    }
    
}

