//
//  ViewController.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

let kTestCellID = "kTestCellID"
class ViewController: UIViewController {
    
    var count:Int = 30
    
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = JYWaterFallFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kTestCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
//        setCollectionView()
        
        setPageCollectionView()
        
        /*
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height)
//        let titles = ["推荐","娱乐","游戏","趣玩"]
        let titles = ["推荐","娱乐","游戏","趣玩娱乐","推荐娱乐娱乐","娱乐娱乐","游戏","趣娱玩"]
        var childVCs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.addSubview(collectionView)
            vc.view.backgroundColor = UIColor.init(hex: "##ff0022")
            childVCs.append(vc)
        }
        var style = JYPageStyle()
        style.isScrollViewEnable = true
//        style.isNeedScale = true
        style.isShowBottomLine = false
        style.isShowCoverView = true
        let pageView = JYPageView(frame: frame, titles: titles, style: style, childVCs: childVCs, parentVC: self)
        
        view.addSubview(pageView)
        */
    }

    
    private func setCollectionView() {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.automatic
        self.view.addSubview(collectionView)
    }
    
    func setPageCollectionView(){
        let pageCollecitonViewF = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        let titles:[String] = ["热门","高级","豪华","专属"]
        var style:JYPageStyle = JYPageStyle()
        style.isShowBottomLine = true
        let pageCollectionView = JYPageCollectionView(frame: pageCollecitonViewF, titles: titles, style: style, isTitleInTop: true)
        
        view.addSubview(pageCollectionView)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTestCellID, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(JYLiveViewController(), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            count += 30
            collectionView.reloadData()
        }
    }
}


extension ViewController : JYWaterFallFlowLayoutDataSource {
    func waterFallFlowLayout(_ waterFallFlow: JYWaterFallFlowLayout, itemIndex: Int) -> CGFloat {
        let screenW = UIScreen.main.bounds.width
        return itemIndex % 2 == 0 ? screenW * 2 / 3 : screenW * 0.5
//        return CGFloat(arc4random_uniform(200) + 50)
    }
}

