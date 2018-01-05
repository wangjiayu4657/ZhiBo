//
//  JYPageStyle.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

struct JYPageStyle {
    //标题视图的高度
    var titleHiight:CGFloat = 44.0
    //标题字体的大小
    var titleFont = UIFont.systemFont(ofSize: 14)
    //标题默认的颜色
    var normalColor = UIColor.lightGray
    //标题选中时的颜色
    var selectColor = UIColor.orange
    //标题之间的间距,默认为20
    var margin:CGFloat = 20
    //标题是否可以滚动
    var isScrollViewEnable:Bool = false
    
}
