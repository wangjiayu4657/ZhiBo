//
//  JYWaterFallFlowLayout.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/12.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit

protocol JYWaterFallFlowLayoutDataSource : class {
    func waterFallFlowLayout(_ waterFallFlow:JYWaterFallFlowLayout,itemIndex:Int) -> CGFloat
}

class JYWaterFallFlowLayout: UICollectionViewFlowLayout {
    //列数
    var col = 2
    weak var dataSource:JYWaterFallFlowLayoutDataSource?
    fileprivate lazy var attributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var heights:[CGFloat] = Array(repeatElement(sectionInset.top, count: col))
    fileprivate lazy var maxHeight:CGFloat = self.sectionInset.top + self.sectionInset.bottom
}

/// MARK: - 准备所有cell的布局
extension JYWaterFallFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        //获取collectionView item的个数
        let count = collectionView.numberOfItems(inSection: 0)
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * (CGFloat(col - 1))) / CGFloat(col)
        //遍历并布局每个item
        for i in attributes.count..<count {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let itemH = dataSource?.waterFallFlowLayout(self, itemIndex: i) ?? 100.0
            let minH = heights.min()!
            let minIndex = heights.index(of: minH)!
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(minIndex)
            let itemY = minH
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            print(attribute.frame)
            
            attributes.append(attribute)
            heights[minIndex] = attribute.frame.maxY + minimumLineSpacing
        }
        
        maxHeight = heights.max()! - minimumLineSpacing
    }
}


/// MARK: - 返回所有准备好的布局
extension JYWaterFallFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

/// MARK: - 设置滑动的范围
extension JYWaterFallFlowLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight + sectionInset.bottom)
    }
}











