//
//  ViewController.swift
//  XSUtil
//
//  Created by git on 04/23/2018.
//  Copyright (c) 2018 git. All rights reserved.
//

import UIKit
import XSUtil

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let topv = XSButtonView(dataSource: [[XSButtonViewDataSourceKey.title: "扫一扫", XSButtonViewDataSourceKey.imageName: "home_scan"], [XSButtonViewDataSourceKey.title: "支付", XSButtonViewDataSourceKey.imageName: "home_pay"], [XSButtonViewDataSourceKey.title: "卡券", XSButtonViewDataSourceKey.imageName: "home_card"], [XSButtonViewDataSourceKey.title: "咻一咻", XSButtonViewDataSourceKey.imageName: "home_xiu"]], color: UIColor.white)
        topv.frame = CGRect(x: 0, y: 100, width: view.width, height: 115)
        topv.backgroundColor = UIColor.purple
        topv.delegate = self
        view.addSubview(topv)
        
        let iv = UIImageView(frame: CGRect(x: 100, y: 250, width: 200, height: 200))
        view.addSubview(iv)

        let img = setupQRCodeImage(with: "https://www.baidu.com", iconImage: UIImage(imageLiteralResourceName: "3fb66db4085f.jpg"))
        iv.image = img
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: XSButtonViewDelegate {
    func buttonView(_ buttonView: XSButtonView, didSelectButton index: Int) {
        if index % 2 == 0 {
            XSStatusBarHUD.showSuccess()
        } else {
            XSHUD.showSuccess(text: "恭喜你注册成功")
        }
    }
}

