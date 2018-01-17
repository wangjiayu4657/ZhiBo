//
//  JYPageCollectionView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/17.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit

private let kCollectionViewCellID = "kCollectionViewCellID"

class JYPageCollectionView: UIView {

    private let titles:[String]
    private let style:JYPageStyle
    private let isTitleInTop:Bool
    
    init(frame: CGRect,titles:[String],style:JYPageStyle,isTitleInTop:Bool) {
        self.titles = titles
        self.style = style
        self.isTitleInTop = isTitleInTop
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JYPageCollectionView {
    fileprivate func setupUI(){
        //创建titleView
        let titleViewY = isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        let titleView = JYTitlesView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
        
        //创建collectionView
        let collectionViewY = isTitleInTop ? style.titleHeight : 0
        let collectionViewH = bounds.height - style.titleHeight - style.pageControlHeight
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: collectionViewH)
        let layout = JYPageCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemMargin = 5
        layout.lineMargin = 5
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        addSubview(collectionView)
        
        //创建pageControl
        let pageControlFrame = CGRect(x: 0, y: collectionView.frame.maxY, width: bounds.width, height: style.pageControlHeight)
        let pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 3
        addSubview(pageControl)
    }
}

extension JYPageCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}















