//
//  ChatTableView.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class ChatTableView: UITableView {

    lazy var messageData: [Message] = {
        var array = [Message]()
        var message1 = Message.init()
        message1.msgType = .text
        message1.msgBody = "测试数据"
        message1.msgDirection = .incoming
        
        var message2 = Message.init()
        message2.msgType = .text
        message2.msgBody = "这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条测试数据这是一条这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据这是一条很长很长很长的测试数据"
        message2.msgDirection = .outComing
        
        array.append(message1)
        array.append(message2)
        return array
    }()
    
   
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        registerCell()
        setupUI()
        setupDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCell() {
        register(TextTableViewCell.self, forCellReuseIdentifier: kCellIdentifierLeft+MessageType.text
        .rawValue)
        register(TextTableViewCell.self, forCellReuseIdentifier: kCellIdentifierRight+MessageType.text
            .rawValue)
    }
    func setupUI() {
        backgroundColor = UIColor.init(white: 241.0/255.0, alpha: 1)
        separatorStyle = .none
        tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 15))
    }
    func setupDelegate() {
        delegate = self
        dataSource = self
    }
}

extension ChatTableView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messageData[indexPath.row]
        if message.msgType == .text {
            // 计算不准确
            var height = Helper.getLabelHeight(text: message.msgBody, font: 16, width: screenW-2*(kAvatarSize + 18 + 12))
            if height < kAvatarSize {
                height = kAvatarSize+kAvatarMarginH
            }else{
                height = height+90
            }
            return height
        }else {// 为以后其他类型预留
            
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageData[indexPath.row]
        if message.msgType == .text {
            let textCell = tableView.dequeueReusableCell(withIdentifier: message.identifier) as! TextTableViewCell
            textCell.message = message
            return textCell
        }else {// 为以后其他类型预留
            let cell = tableView.dequeueReusableCell(withIdentifier: message.identifier)
            return cell!
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name.MenuWillHideNoti, object: nil)
    }

}
