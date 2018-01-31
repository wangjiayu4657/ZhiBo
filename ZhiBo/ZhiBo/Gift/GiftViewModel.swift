//
//  GiftViewModel.swift
//  ZhiBo
//
//  Created by wangjiayu on 2018/1/26.
//  Copyright © 2018年 wangjiayu. All rights reserved.
//

import UIKit
import Alamofire

class GiftViewModel:NSObject, JYRequestable {
    
    var url: String = "http://qf.56.com/pay/v4/giftList.ios"
    var params: [String : Any] = ["type":0,"page":1,"rows":150]
    var type: HTTPMethod = HTTPMethod.get
    typealias resultData = [GiftPackages]
    var result: [GiftPackages] = []
    
//    var gifPackages:[GiftPackages] = [GiftPackages]()
}

extension GiftViewModel {
    
    func parseData(_ result: Any) {
        //判断response是否是一个字典
        guard let resultDic = result as? [String : Any] else { return }
        
        //取出需要的数据
        guard let dataDict = resultDic["message"] as? [String : Any] else { return }
        
        for i in 0..<dataDict.count {
            guard let typeDict = dataDict["type\(i+1)"] as? [String : Any] else { return }
            self.result.append(GiftPackages.init(dict: typeDict))
        }
        
        self.result = self.result.filter({$0.t != 0}).sorted(by: {$0.t > $1.t})
    }
    
 
//    func requestGiftData(_ completed:@escaping ([GiftPackages])->Void) {
//        let param:[String:Any] = ["type":0,"page":1,"rows":150]
//        JYNetworkTools.shareInstance.requestData("http://qf.56.com/pay/v4/giftList.ios", methodType.get, params:param) { (response : Any) in
//
//            print(response)
//            //判断response是否是一个字典
//            guard let resultDic = response as? [String : Any] else { return }
//
//            //取出需要的数据
//            guard let dataDict = resultDic["message"] as? [String : Any] else { return }
//
//            for i in 0..<dataDict.count {
//                guard let typeDict = dataDict["type\(i+1)"] as? [String : Any] else { return }
//                self.gifPackages.append(GiftPackages.init(dict: typeDict))
//            }
//
//            self.gifPackages = self.gifPackages.filter({$0.t != 0}).sorted(by: {$0.t > $1.t})
//
//            completed(self.gifPackages)
//        }
//    }

}
