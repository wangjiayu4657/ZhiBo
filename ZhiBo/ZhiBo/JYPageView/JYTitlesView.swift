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
    
    //MARK:- 懒加载
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView(frame: self.bounds)
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
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


//MARK:- 设置UI界面
extension JYTitlesView {
    fileprivate func setupUI() {
        self.backgroundColor = UIColor.blue
        addSubview(scrollView)
        var titleLabels:[UILabel] = [UILabel]()
        for (i,title) in titles.enumerated() {
            //创建Label
            let titleLabel = UILabel()
            
            //设置label的属性
            titleLabel.text = title
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.isUserInteractionEnabled = true
            titleLabel.textColor = (i == 0) ? style.selectColor : style.normalColor
            titleLabel.font = style.titleFont
            
            //添加点击手势
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            
            titleLabels.append(titleLabel)
            scrollView.addSubview(titleLabel)
        }
        
        //设置label的frame
        var labelX:CGFloat = 0
        let labelY:CGFloat = 0
        var labelW:CGFloat = bounds.width / CGFloat(titles.count)
        let labelH:CGFloat = style.titleHiight
        
        for (i,titleLabel) in titleLabels.enumerated() {
            if style.isScrollViewEnable {
                let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
                labelW = (titleLabel.text! as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:style.titleFont], context: nil).width
                labelX = i == 0 ? style.margin * 0.5 : titleLabels[i - 1].frame.maxX + style.margin
            }else {
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        
        //设置scrollView的contentSize
        if style.isScrollViewEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + style.margin * 0.5, height: 0)
        }
    }
}
//MARK:- 监听点击事件
extension JYTitlesView {
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer) {
        guard let titleLabel = tapGes.view as? UILabel else { return }
        print(titleLabel.tag)
    }
}















