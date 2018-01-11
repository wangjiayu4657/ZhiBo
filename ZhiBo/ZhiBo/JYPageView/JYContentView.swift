//
//  JYContentView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

protocol JYContentViewDelegate:class {
    func contentView(_ contentView:JYContentView,endScrollInIndex index:Int)
    func contentView(_ contentView:JYContentView,sourceIndex:Int,targetIndex:Int,progress:CGFloat)
}

private let kContentCellID = "kContentCellID"

class JYContentView: UIView {
    
    //MARK:- 代理属性
    weak var delegate:JYContentViewDelegate?
    
    //MARK:- 属性
    var childVCs:[UIViewController]
    var parentVC:UIViewController
    var isForbidDelegate:Bool = false //点击标题时禁止collectionView滚动
    fileprivate var startOffsetX:CGFloat = 0
    
    //MARK:- 懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cView.bounces = false
        cView.delegate = self
        cView.dataSource = self
        cView.isPagingEnabled = true
        cView.showsHorizontalScrollIndicator = false
        cView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        return cView
    }()
    
    init(frame: CGRect,childVCs:[UIViewController],parentVC:UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI界面
extension JYContentView {
    fileprivate func setupUI() {
        print(frame);
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
        //添加子控件
        addSubview(collectionView)
    }
}

//MARK:- 遵守UIcollectionViewDataSource协议
extension JYContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let controller = childVCs[indexPath.row];
        controller.view.backgroundColor = UIColor.randomColor()
        cell.contentView.addSubview(controller.view)
        return cell
    }
}

//MARK:- 遵守UIcollectionViewDelegate协议
extension JYContentView : UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            scrollViewDidEndScroll()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetX = scrollView.contentOffset.x
        guard !isForbidDelegate else { return } //如果当前没有滑动则不进行任何操作
        
        //定义所需传递的变量
        var sourceIndex = 0
        var targetIndex = 0
        var progress:CGFloat = 0.0
        let collectionWidth = collectionView.bounds.width
        
        if currentOffsetX > startOffsetX { //左滑动
            sourceIndex = Int(currentOffsetX / collectionWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            let val = (currentOffsetX - startOffsetX).truncatingRemainder(dividingBy: collectionWidth)
            if val == 0 { targetIndex = sourceIndex }
            
            progress = (currentOffsetX - startOffsetX) / collectionWidth
        } else { //右滑动
            targetIndex = Int(currentOffsetX / collectionWidth)
            if currentOffsetX == startOffsetX {
                sourceIndex = targetIndex - 1
                if sourceIndex < 0 {
                    sourceIndex = -sourceIndex
                }
                progress = 1.0
            }else {
                sourceIndex = targetIndex + 1
                progress = (startOffsetX - currentOffsetX) / collectionWidth
            }
        }
        
        delegate?.contentView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
    
    //scrollView停止滚动
    private func scrollViewDidEndScroll(){
        let index = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, endScrollInIndex: index)
    }
}

//MARK:- 遵守JYTitlesViewDelegate
extension JYContentView : JYTitlesViewDelegate {
    func titleViewSelectIndex(_ titleView: JYTitlesView, currentIndex: Int) {
        isForbidDelegate = true
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

















