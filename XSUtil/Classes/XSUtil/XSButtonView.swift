//
//  XSButtonView.swift
//  ZFBDemo
//
//  Created by hxs on 2018/4/23.
//  Copyright © 2018年 hxs. All rights reserved.
//

import UIKit
import XSExtension
import SnapKit

public enum XSButtonViewDataSourceKey: String {
    case title, imageName
}

public protocol XSButtonViewDelegate: NSObjectProtocol {
    
    func buttonView(_ buttonView: XSButtonView, didSelectButton index: Int)
}

open class XSButtonView: UIView {
    
    public weak var delegate: XSButtonViewDelegate?
    
    deinit {
        debugPrint("XSButtonView deinit")
    }
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - dataSource: 按钮数据源
    ///   - imageWH: 按钮图片宽高
    ///   - fontSize: 按钮文字大小
    ///   - color: 按钮文字颜色
    ///   - space: 按钮图片与文字间距
    public init(dataSource: [[XSButtonViewDataSourceKey: String]],
         imageWH: CGFloat = 35,
         fontSize: CGFloat = 16,
         color: UIColor = UIColor.darkGray,
         space: CGFloat = 8) {
        super.init(frame: CGRect.zero)

        for dict in dataSource {
            guard let title = dict[XSButtonViewDataSourceKey.title],
                let imageName = dict[XSButtonViewDataSourceKey.imageName],
                let image = UIImage(named: imageName) else {
                    return
            }
            
            let btn = UIButton(img: image, title: title, wh: imageWH, fontSize: fontSize, color: color, space: space)
            btn.addTarget(self, action: #selector(XSButtonView.clickButton), for: .touchUpInside)
            addSubview(btn)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        for (index, button) in subviews.enumerated() {
            button.tag = index
            if index == 0 {
                button.snp.makeConstraints { (make) in
                    make.left.top.bottom.equalToSuperview()
                }
            } else if index == subviews.count - 1 {
                button.snp.makeConstraints { (make) in
                    make.top.bottom.right.equalToSuperview()
                    make.left.equalTo(subviews[index - 1].snp.right)
                    make.width.equalTo(subviews[index - 1])
                }
            } else {
                button.snp.makeConstraints { (make) in
                    make.top.bottom.equalToSuperview()
                    make.left.equalTo(subviews[index - 1].snp.right)
                    make.width.equalTo(subviews[index - 1])
                }
            }
        }
    }
    
    @objc private func clickButton(_ button: UIButton) {
        delegate?.buttonView(self, didSelectButton: button.tag)
    }

}
