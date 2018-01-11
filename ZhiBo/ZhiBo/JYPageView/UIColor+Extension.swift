//
//  UIColor+Extension.swift
//  ZhiBo
//
//  Created by wangjiayu on 2017/12/16.
//  Copyright © 2017年 wangjiayu. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    convenience  init(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience  init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    convenience init?(hex:String) {
        guard hex.count >= 6 else { return nil }
        var tempHex = hex.uppercased()
        
        var r:Float = 0.0
        var g:Float = 0.0
        var b:Float = 0.0
        
        if tempHex.hasPrefix("0X") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        
        if tempHex.hasPrefix("#") {
              tempHex = (tempHex as NSString).substring(from: 2)
        }
        
        var range = NSRange.init(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        Scanner(string: rHex).scanFloat(&r)
        Scanner(string: gHex).scanFloat(&g)
        Scanner(string: bHex).scanFloat(&b)
        
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
    }
}
extension UIColor {
    func getRGBValue()->(CGFloat,CGFloat,CGFloat) {
        
//        guard let comps = cgColor.components else {
//            fatalError("请确保颜色是通过RGB创建的")
//        }
//
//        print(comps)
//
//        return (comps[0] * 255, comps[1] * 255, comps[2] * 255)
//
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        //获取rgbd
        getRed(&r, green: &g, blue: &b, alpha: nil)
        return (r * 255,g * 255,b * 255)
    }
}
