//
//  MainViewController.swift
//  YU
//
//  Created by GaoShuai on 17/2/7.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Profile")
        addChildVc("Flollow")
    }
    fileprivate func addChildVc(_ stroyBoardName:String) {
        let childVc = UIStoryboard(name: stroyBoardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
        
    }
   
}
extension MainViewController{
   
   
    
}
