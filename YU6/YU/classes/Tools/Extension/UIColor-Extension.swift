//
//  UIColor-Extension.swift
//  YU
//
//  Created by GaoShuai on 17/3/27.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit


// 十六进制颜色转换
extension UIColor{
    
    convenience init(hexColor: String){
        var red : UInt32 = 0
        var green : UInt32 = 0
        var blue : UInt32 = 0
        

        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    convenience init(reder : Int,_ greener: Int,_ blueer: Int,_ alpha: CGFloat) {
        self.init(red: CGFloat(reder)/255.0, green: CGFloat(greener)/255.0, blue: CGFloat(blueer)/255.0, alpha: alpha)
    }

}

extension String{
    subscript(range : Range<Int>) -> String{
        get{
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            
             let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            
            return self[startIndex..<endIndex]
        }
    }
    
}

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
