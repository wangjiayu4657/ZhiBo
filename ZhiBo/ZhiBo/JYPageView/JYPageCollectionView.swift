//
//  JYPageCollectionView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/17.
//  Copyright © 2018年 wangjiayu. All rights reserved.
 

import UIKit

private let kCollectionViewCellID = "kCollectionViewCellID"


protocol JYPageCollectionViewDataSource:class {
    //总共有多少组
    func numberOfSection(_ pageCollectionView:JYPageCollectionView) -> Int
    //每组有多少Item
    func pageCollectionView(_ pageCollectionView:JYPageCollectionView,numberOfPageInSection section:Int) ->Int
    //返回cell的样式
    func pageCollectionView(_ pageCollectionView:JYPageCollectionView,_ collectionView:UICollectionView,pageItemAt indexPath:IndexPath) ->UICollectionViewCell
}

class JYPageCollectionView: UIView {

    //定义属性
    private let titles:[String]
    private let style:JYPageStyle
    fileprivate var collectionView:UICollectionView!
    fileprivate var layout:JYPageCollectionLayout
    weak var dataSource:JYPageCollectionViewDataSource?
    
    init(frame: CGRect,titles:[String],style:JYPageStyle,layout:JYPageCollectionLayout) {
        self.titles = titles
        self.style = style
        self.layout = layout
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
//        collectionView.register(UINib, forCellWithReuseIdentifier: kCollectionViewCellID)
    }
}

extension JYPageCollectionView {
    fileprivate func setupUI(){
        //创建titleView
        let titleViewY = style.isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        let titleView = JYTitlesView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
        
        //创建collectionView
        let collectionViewY = style.isTitleInTop ? style.titleHeight : 0
        let collectionViewH = bounds.height - style.titleHeight - style.pageControlHeight
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: collectionViewH)
        
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        addSubview(collectionView)
        self.collectionView = collectionView
        
        //创建pageControl
        let pageControlFrame = CGRect(x: 0, y: collectionView.frame.maxY, width: bounds.width, height: style.pageControlHeight)
        let pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 3
        addSubview(pageControl)
    }

    func register(_ cellClass:AnyClass?,pageCellWithIdentifier:String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: pageCellWithIdentifier)
    }
    
    func register(nib:UINib?, pageCellWithIdentifier:String){
        collectionView.register(nib, forCellWithReuseIdentifier: pageCellWithIdentifier)
    }
}

extension JYPageCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSection(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.pageCollectionView(self, numberOfPageInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataSource!.pageCollectionView(self, collectionView, pageItemAt: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}















