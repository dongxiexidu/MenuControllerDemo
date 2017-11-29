//
//  ChateController.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class ChateController: UIViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name.MenuWillHideNoti, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "假的聊天页面"
        setupUI()
    }
   
    func setupUI() {
        let tableView = ChatTableView.init()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
