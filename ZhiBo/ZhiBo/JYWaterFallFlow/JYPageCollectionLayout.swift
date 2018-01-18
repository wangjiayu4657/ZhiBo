//
//  JYPageCollectionLayout.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/17.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//  横向流水布局 

import UIKit

class JYPageCollectionLayout: UICollectionViewFlowLayout {
    var cols:Int = 4
    var rows:Int = 2
    var itemMargin:CGFloat = 0
    var lineMargin:CGFloat = 0
    fileprivate var totalWidth:CGFloat = 0
    fileprivate lazy var attributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
}


/// MARK: - 准备所有Item的布局
extension JYPageCollectionLayout {
    override func prepare() {
        super.prepare()
        
        //校验collectionView
        guard let collectionView = collectionView else { return }
        
        //获取collectionView的section
        let sections = collectionView.numberOfSections
        
        //计算itemSize
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * itemMargin) / CGFloat(cols)
        let itemH = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - CGFloat(rows - 1) * lineMargin) / CGFloat(rows)
        
        //前面共有多少页
        var previousNumOfPage = 0
        
        //遍历sections取出每组中的item
        for section in 0..<sections {
            //取出每组中的item
            let items = collectionView.numberOfItems(inSection: section)
            //遍历Items布局每个Item
            for item in 0..<items {
                //创建
                let indexPath = IndexPath(item: item, section: section)
                let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let currentPage = item / (cols * rows)
                let currentIndex = item % (cols * rows)
                
                let itemX = CGFloat(previousNumOfPage + currentPage) * collectionView.bounds.width + sectionInset.left + (itemW + itemMargin) * CGFloat(currentIndex % cols)
                let itemY = sectionInset.top + (itemH + lineMargin) * CGFloat(currentIndex / cols)
                layoutAttributes.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                attributes.append(layoutAttributes)
            }
            
            previousNumOfPage += (items - 1) / (cols * rows) + 1
        }
        totalWidth = CGFloat(previousNumOfPage) * collectionView.bounds.width
    }
}


/// MARK: - 将所有布局好的Item返回
extension JYPageCollectionLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

/// MARK: - 返回contentSize
extension JYPageCollectionLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: totalWidth, height: 0)
    }
}








