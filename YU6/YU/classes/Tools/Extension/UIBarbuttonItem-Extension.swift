//
//  UIBarbuttonItem-Extension.swift
//  YU
//
//  Created by GaoShuai on 17/2/7.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    convenience init(normalmage:String, selectedImage:String = "", size : CGSize = CGSize.zero) {
        let button = UIButton()
        button.setImage(UIImage.init(named: normalmage), for: .normal)
        if selectedImage != "" {
            button.setImage(UIImage.init(named: selectedImage), for: .selected)
        }
        
        if size == CGSize.zero {
            button.sizeToFit()
        }else{
            button.frame.size = size
        }
        self.init(customView : button)
    }
}
