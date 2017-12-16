//
//  JYTitlesView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

class JYTitlesView: UIView {

    //MARK:- 属性
    var titles:[String]
    var style:JYPageStyle
    
    init(frame: CGRect,titles:[String],style:JYPageStyle) {
        self.titles = titles
        self.style = style
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension JYTitlesView {
    fileprivate func setupUI() {
        self.backgroundColor = UIColor.blue
    }
}
