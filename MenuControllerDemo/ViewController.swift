//
//  ViewController.swift
//  MenuControllerDemo
//
//  Created by fashion on 2017/11/29.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
    @IBAction func buttonClick(_ sender: Any) {
        self.navigationController?.pushViewController(ChateController(), animated: true)
    }
    

}

