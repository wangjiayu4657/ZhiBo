//
//  GiftModel.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/26.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit

class GiftModel: NSObject {
    var img2 : String = ""
    var subject : String = "" {
        didSet {
            if subject.contains("(有声)"){
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
    var gUrl : String = ""
    var coin : Int = 0
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
