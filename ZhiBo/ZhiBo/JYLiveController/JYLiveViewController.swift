//
//  JYLiveViewController.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/15.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit

private let kCollectionViewCellID = "kCollectionViewCellID"

class JYLiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray
        
        setPageCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension JYLiveViewController {
    func setPageCollectionView(){
        let pageCollecitonViewF = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        let titles:[String] = ["热门","高级","豪华","专属"]
        var style:JYPageStyle = JYPageStyle()
        style.isShowBottomLine = true
        
        let layout = JYPageCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemMargin = 5
        layout.lineMargin = 5
        layout.cols = 7
        layout.rows = 3
        layout.scrollDirection = .horizontal
        
        let pageCollectionView = JYPageCollectionView(frame: pageCollecitonViewF, titles: titles, style: style, layout:layout)
        pageCollectionView.dataSource = self
        
        view.addSubview(pageCollectionView)
    }
}

extension JYLiveViewController : JYPageCollectionViewDataSource {
    func numberOfSection(_ pageCollectionView: JYPageCollectionView) -> Int {
        return 4
    }
    
    func pageCollectionView(_ pageCollectionView: JYPageCollectionView, numberOfPageInSection section: Int) -> Int {
        return 30
    }
    
    func pageCollectionView(_ pageCollectionView: JYPageCollectionView, _ collectionView: UICollectionView, pageItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:kCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
