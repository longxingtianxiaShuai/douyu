//
//  ReCommentViewModel.swift
//  YU
//
//  Created by 高帅 on 2017/4/22.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit
import NetworkExtension

class ReCommentViewModel: NSObject {
   lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
   
    
}


// MARK : - 请求数据
extension ReCommentViewModel{
    
  func requestRecommentDate(){
        // 请求颜值数据
        
        // 请求热门数据
    
        // 请求2-12部分游戏数据
    var parameters =  [String : String]()
    parameters["time"] = "1492755749"
    parameters["limit"] = "0"
    parameters["offset"] = "0"
    
    NetworkTools.requestDate(methodType: .get, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (response) in
        guard let resultDict = response as? [String : Any] else{return}
        
        guard let dataArray = resultDict["data"] as? [[String : Any]]else{return}
        
        for dict in dataArray{
            print(dict["tag_name"])
            self.anchorGroups.append(AnchorGroup(dict: dict))
           
        }
        
        for anchorgroup in self.anchorGroups{
                print("====== %@",anchorgroup.tag_name)
        }
    }
        
    }
    
    
    
}
