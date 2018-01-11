//
//  JYTitlesView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

protocol JYTitlesViewDelegate:class {
    func titleViewSelectIndex(_ titleView:JYTitlesView,currentIndex:Int)
}

class JYTitlesView: UIView {

    //MARK:- 属性
    var currentIndex:Int = 0
    fileprivate var titles:[String]
    fileprivate var style:JYPageStyle
    weak var delegate:JYTitlesViewDelegate?
    
    //MARK:- 懒加载
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    fileprivate lazy var normalRGB:(CGFloat,CGFloat,CGFloat) = self.style.normalColor.getRGBValue()
    fileprivate lazy var selectRGB:(CGFloat,CGFloat,CGFloat) = self.style.selectColor.getRGBValue()
    fileprivate lazy var deltaRGB:(CGFloat,CGFloat,CGFloat) = {
        var deltaR = self.selectRGB.0 - self.normalRGB.0
        var deltaG = self.selectRGB.1 - self.normalRGB.1
        var deltaB = self.selectRGB.2 - self.normalRGB.2
        return (deltaR,deltaG,deltaB)
    }()
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView(frame: self.bounds)
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private lazy var bottomLine:UIView = {
        let line = UIView()
        line.backgroundColor = self.style.selectColor
        return line
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
        self.backgroundColor = UIColor.lightGray
        addSubview(scrollView)
        
        setupTitleLabel()
        setupBottomLine()
    }
    
    //设置标题
    private func setupTitleLabel() {
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
        let labelH:CGFloat = style.titleHeight
        
        for (i,titleLabel) in titleLabels.enumerated() {
            if style.isScrollViewEnable {
                let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
                labelW = (titleLabel.text! as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:style.titleFont], context: nil).width
                labelX = (i == 0) ? style.margin * 0.5 : (titleLabels[i - 1].frame.maxX + style.margin)
            }else {
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        
        //设置scrollView的contentSize
        if style.isScrollViewEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + style.margin * 0.5, height: 0)
        }
        
        //缩放标题
        if style.isNeedScale {
            titleLabels.first?.transform = CGAffineTransform(scaleX: style.maxScale, y: style.maxScale)
        }
    }
    
    //添加下划线
    private func setupBottomLine() {
        if style.isShowBottomLine {
            scrollView.addSubview(bottomLine)
            bottomLine.frame = titleLabels.first!.frame
            bottomLine.frame.size.height = style.bottomLineHeight
            bottomLine.frame.origin.y = style.titleHeight - style.bottomLineHeight
        }
    }
}
//MARK:- 监听点击事件
extension JYTitlesView {
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer) {
        guard let targetLabel = tapGes.view as? UILabel else { return } //获取目标label
        guard currentIndex != targetLabel.tag else { return } //如果连续两次选中的是同一个label则不需要后面的操作
        
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor

        currentIndex = targetLabel.tag
        
        adjustTitleLabelPostion()
        
        delegate?.titleViewSelectIndex(self, currentIndex: currentIndex)
        
        //缩放
        if style.isNeedScale {
            sourceLabel.transform = CGAffineTransform.identity
            targetLabel.transform = CGAffineTransform(scaleX: self.style.maxScale, y: self.style.maxScale)
        }

        //调整下划线的位置
        if style.isShowBottomLine {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomLine.frame.origin.x = targetLabel.frame.origin.x
                self.bottomLine.frame.size.width = targetLabel.frame.width
            })
        }
    }
    
    //调整titleLabel的位置
    fileprivate func adjustTitleLabelPostion() {
        var offsetX = titleLabels[currentIndex].center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        let maxOffsetX = scrollView.contentSize.width - scrollView.bounds.width
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
    
}

//MARK:- 遵守JYContentViewDelegate
extension JYTitlesView : JYContentViewDelegate {
    func contentView(_ contentView: JYContentView, endScrollInIndex index: Int) {
        currentIndex = index
        adjustTitleLabelPostion()
    }
    
    func contentView(_ contentView: JYContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        
        //缩放标题字体
        let deltaScale = style.maxScale - 1.0
        if style.isNeedScale {
            UIView.animate(withDuration: 0.25, animations: {
                let scale = self.style.maxScale
                let deltaProgress = deltaScale * progress
                sourceLabel.transform = CGAffineTransform(scaleX: scale - deltaProgress, y: scale - deltaProgress)
                targetLabel.transform = CGAffineTransform(scaleX: 1.0 + deltaProgress, y: 1.0 + deltaProgress)
            })
        }

        //调整bottomLine的位置及宽度
        let deltaW = targetLabel.frame.width - sourceLabel.frame.width
        let deltaX = targetLabel.center.x - sourceLabel.center.x
        if style.isShowBottomLine {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomLine.center.x = sourceLabel.center.x + deltaX * progress
                self.bottomLine.frame.size.width = sourceLabel.frame.width + deltaW * progress
            })
        }
    }
}

//UIViewAlertForUnsatisfiableConstraints
//po [[UIWindow keyWindow] _autolayoutTrace]










