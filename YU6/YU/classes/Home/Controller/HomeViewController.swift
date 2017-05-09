//
//  HomeViewController.swift
//  YU
//
//  Created by GaoShuai on 17/2/7.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let frame = CGRect(x: 0.0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: 40.0)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
        
       
    }()
    fileprivate lazy var pageContentView : PageContentView = {
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH  + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        let recommentVc = RecommendViewController()
        childVcs.append(recommentVc)
        for _ in 0 ..< 3 {
            let vc = UIViewController()
             vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        
        return pageContentView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBarButtonItem()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
       
    }
}

//MARK: - 设置UI

extension HomeViewController{
   fileprivate func setUpUI() {
        setUpBarButtonItem()
    
    }
    fileprivate func setUpBarButtonItem() {
      
        
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(normalmage: "image_my_history", selectedImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(normalmage: "btn_search", selectedImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(normalmage: "Image_scan", selectedImage: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
   
    
    
}


// MARK : - pageContentView协议

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
          print("progress ===  ",progress,sourceIndex,targetIndex)
        
        pageTitleView.pageTitleView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK : - pageTitleView
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleViewClick(_ pageTitleView: PageTitleView, selectedIndex index: Int) {
        print("======== \(index)")
        pageContentView.setCurrentIndex(index)
    }
}















