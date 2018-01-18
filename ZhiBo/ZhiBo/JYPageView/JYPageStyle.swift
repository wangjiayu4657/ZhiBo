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
    var titleHeight:CGFloat = 44.0
    //标题字体的大小
    var titleFont = UIFont.systemFont(ofSize: 14)
    //标题默认的颜色
    var normalColor = UIColor(r: 255, g: 255, b: 255)
    //标题选中时的颜色
    var selectColor = UIColor(r: 255, g: 127, b: 0)
    //标题之间的间距,默认为20
    var margin:CGFloat = 20
    
    //标题是否可以滚动
    var isScrollViewEnable:Bool = false
    //标题下是否显示下划线
    var isShowBottomLine:Bool = true
    //标题下划线的颜色
    var bottomLineColor:UIColor = UIColor.orange
    //底部滑动条的高度
    var bottomLineHeight:CGFloat = 2.0
    
    //是否需要缩放
    var isNeedScale:Bool = false
    //最大缩放比例
    var maxScale:CGFloat = 1.2
    
    //是否显示遮盖效果
    var isShowCoverView:Bool = false
    //遮盖视图的背景颜色
    var coverViewColor:UIColor = UIColor.darkGray
    //遮盖视图的透明度
    var coverViewAlpha:CGFloat = 0.3
    //遮盖视图的间距
    var coverViewMargin:CGFloat = 10
    
    //pageControl的高度 
    var pageControlHeight:CGFloat = 20
    //标题是否在顶部
    var isTitleInTop:Bool = true
}

