//
//  JYNavigationController.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/15.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit

class JYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let interactiveGes = interactivePopGestureRecognizer else { return }
        guard let values = interactiveGes.value(forKeyPath: "_targets") as? [NSObject] else { return }
        guard let objc = values.first else { return }
        
        let target = objc.value(forKeyPath: "target")
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
