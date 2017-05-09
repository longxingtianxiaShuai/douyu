//
//  AnchorGroup.swift
//  YU
//
//  Created by 高帅 on 2017/4/22.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    var  icon_name : String = "home_header_normal"
    
    var tag_name : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
