//
//  Message.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

enum MessageDirection {
    case incoming // 收到的消息
    case outComing  // 发出的消息
}

enum MessageType : String {
    case text = "text"
    case image = "image"
    case voice = "voice"
}

let kCellIdentifierLeft = "ChatroomIdentifierLeft"
let kCellIdentifierRight = "ChatroomIdentifierRight"


struct Message {
    var msgId = ""
    var msgBody = ""
    var height : CGFloat = 0
    var identifier : String {
        get{
            let rawIdentifier = self.msgDirection == .incoming ? kCellIdentifierLeft : kCellIdentifierRight
            return String.init(format: "%@%@", rawIdentifier,self.msgType.rawValue)
        }
    }
    
    var msgDirection = MessageDirection.incoming
    var msgType = MessageType.text
}
