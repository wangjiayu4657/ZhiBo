//
//  JYPageView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

class JYPageView: UIView {

    //MARK:- 属性
    var titles:[String]
    var style:JYPageStyle
    var childVCs:[UIViewController]
    var parentVC:UIViewController
    
    //MARK:- 懒加载控件
    fileprivate lazy var titleView : JYTitlesView = JYTitlesView(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: style.titleHiight), titles: titles, style: style)
    fileprivate lazy var contentView : JYContentView = JYContentView(frame: CGRect.init(x: 0, y: style.titleHiight, width: bounds.width, height: bounds.height - style.titleHiight), childVCs: childVCs, parentVC: parentVC)

    //MARK:- 构造函数
    init(frame:CGRect,titles:[String],style:JYPageStyle,childVCs:[UIViewController],parentVC:UIViewController) {
        self.titles = titles
        self.style = style
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JYPageView {
    fileprivate func setupUI() {
        //添加子控件
        addSubview(titleView)
        addSubview(contentView)
    }
}





















