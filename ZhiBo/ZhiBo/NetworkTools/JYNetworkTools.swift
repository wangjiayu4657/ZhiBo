//
//  JYNetworkTools.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/26.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit
import Alamofire

enum methodType {
    case get
    case post
    case patch
    case put
    case head
}

class JYNetworkTools {
    fileprivate var type:String?
    static let shareInstance:JYNetworkTools = JYNetworkTools()
}

extension JYNetworkTools {
       func requestData(_ url:String, _ type:methodType,params:[String:Any],completed:@escaping (Any)->Void) {
        let method:HTTPMethod
        switch type {
            case .post: method = HTTPMethod.post
            case .patch: method = HTTPMethod.patch
            case .put: method = HTTPMethod.put
            default: method = HTTPMethod.get
        }
        
        Alamofire.request(url, method: method, parameters: params).responseJSON { (response) in
            //校验是否有结果
            guard let result = response.result.value else {
                print(response.result.error ?? "有错误")
                return
            }
            
            //回调结果
            completed(result)
        }
    }
}
