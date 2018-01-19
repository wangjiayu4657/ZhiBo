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
    fileprivate var pageControl:UIPageControl!
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
    }
}

extension JYPageCollectionView {
    fileprivate func setupUI(){
        //创建titleView
        let titleViewY = style.isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        let titleView = JYTitlesView(frame: titleFrame, titles: titles, style: style)
        titleView.delegate = self
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
        collectionView.delegate = self
        addSubview(collectionView)
        self.collectionView = collectionView
        
        //创建pageControl
        let pageControlFrame = CGRect(x: 0, y: collectionView.frame.maxY, width: bounds.width, height: style.pageControlHeight)
        let pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.currentPage = 0
        addSubview(pageControl)
        self.pageControl = pageControl
    }
}

/// MARK: - 扩展方法
extension JYPageCollectionView {
    func register(_ cellClass:AnyClass?,pageCellWithIdentifier:String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: pageCellWithIdentifier)
    }
    
    func register(nib:UINib?, pageCellWithIdentifier:String){
        collectionView.register(nib, forCellWithReuseIdentifier:  pageCellWithIdentifier)
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
}

/// MARK: - 遵守 <UICollectionViewDataSource>
extension JYPageCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSection(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = dataSource?.pageCollectionView(self, numberOfPageInSection: section) ?? 0
        if section == 0 {
            pageControl.numberOfPages = (sections - 1) / (layout.rows * layout.cols) + 1
        }
        return sections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataSource!.pageCollectionView(self, collectionView, pageItemAt: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}

/// MARK: - 遵守
extension JYPageCollectionView : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let index = Int(scrollView.contentOffset.x / collectionView.bounds.width) + 1
        print(index)
        pageControl.currentPage = index
    }
}


/// MARK: - 遵守 <JYTitlesViewDelegate>
extension JYPageCollectionView : JYTitlesViewDelegate {
    func titleViewSelectIndex(_ titleView: JYTitlesView, currentIndex: Int) {
        let indexPath = IndexPath(item: 0, section: currentIndex)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        let section = dataSource?.numberOfSection(self) ?? 0
        let itemsInsection = dataSource?.pageCollectionView(self, numberOfPageInSection: currentIndex) ?? 0
        
        pageControl.numberOfPages = (section - 1) / (layout.rows * layout.cols) + 1
        
        if currentIndex == (section - 1) && itemsInsection <= layout.cols * layout.rows { return }
        collectionView.contentOffset.x -= layout.sectionInset.left
    }
}












