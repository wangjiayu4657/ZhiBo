//
//  ViewController.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/15.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height)
        let titles = ["推荐","娱乐","游戏","趣玩"]
        var childVCs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(hex: "##ff0022")
            childVCs.append(vc)
        }
        let style = JYPageStyle()
        let pageView = JYPageView(frame: frame, titles: titles, style: style, childVCs: childVCs, parentVC: self)
        
        view.addSubview(pageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

