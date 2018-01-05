//
//  JYContentView.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class JYContentView: UIView {
    //MARK:- 属性
    var childVCs:[UIViewController]
    var parentVC:UIViewController
    
    //MARK:- 懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cView.delegate = self
        cView.dataSource = self
        cView.isPagingEnabled = true
        cView.bounces = false
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
        
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

//MARK:- 遵守UIcollectionViewDelegate协议
extension JYContentView : UICollectionViewDelegate {
    
}



















