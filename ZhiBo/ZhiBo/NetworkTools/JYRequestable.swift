//
//  JYRequestable.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/30.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit
import Alamofire

protocol JYRequestable {
    var url:String { get }
    var type:HTTPMethod { get }
    var params:[String : Any] { get }
    
    //关联数据
    associatedtype resultData
    
    //结果数据
    var result:resultData { set get }
    
    //解析函数
    func parseData(_ result: Any)
}

extension JYRequestable {
    func requestData(completed:@escaping ()->Void) {
        
        Alamofire.request(url, method: type, parameters: params).responseJSON { (response) in
            //校验是否有结果
            guard let result = response.result.value else {
                print(response.result.error ?? "有错误")
                return
            }
            
            //解析数据
            self.parseData(result)
            
            //回调结果
            completed()
        }
    }
}
