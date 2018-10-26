//
//  TextTableViewCell.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit


class TextTableViewCell: BaseTableViewCell {

    var textView : UILabel!
    
    override func buildCell() {
        super.buildCell()
        
        textView = UILabel()
        textView.numberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 16)
        bubbleView.addSubview(textView)

        if alignement == .right {
            textView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 21))
            })
        }else{
            textView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 21, bottom: 12, right: 16))
            })
        }
    }
    
   override var message: Message? {
        didSet {
            guard let message = message else {
                return
            }
            textView.text = message.msgBody
            textView.sizeToFit()
        }
    }

}
