//
//  GiftPackages.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/26.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit

class GiftPackages: NSObject {
    var t : Int = 0
    var title : String = ""
    var giftModel : [GiftModel] = []
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            if let listArray = value as? [[String:Any]] {
                for dic in listArray {
                    giftModel.append(GiftModel.init(dict: dic))
                }
            }else {
                super.setValue(value, forKey: key)
            }
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
