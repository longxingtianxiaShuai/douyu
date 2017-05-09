//
//  NetworkTools.swift
//  YU
//
//  Created by GaoShuai on 17/3/26.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get
    case post
}

class NetworkTools: NSObject {

}

extension NetworkTools{
   class  func requestDate(methodType : MethodType,url : String,parameters : [String : Any]? = nil,finshCallBack :@escaping (_ result : Any) -> ()) {
        
        let type = methodType == .get ? HTTPMethod.get : HTTPMethod.post
        
       
        Alamofire.request(url, method: type, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
                print("%@",response.result.error ?? "小伙你错了")
                return
            }
            finshCallBack(result)
        }

    }
}
