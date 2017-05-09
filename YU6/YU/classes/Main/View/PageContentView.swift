//
//  PageContentView.swift
//  YU
//
//  Created by 高帅 on 2017/3/29.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit
private let cellID = "cellID"
protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView,progress : CGFloat, sourceIndex : Int,targetIndex : Int)

}

class PageContentView: UIView {

    fileprivate var childVcs : [UIViewController]
    
    //  因为当前view包含了控制器属性  控制器中也添加了当前view 造成了循环引用
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    // 避免事件循环执行
    fileprivate var isForbodScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 设置layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return collectionView
    }()
    
    
    // MARK : - 自定义构造函数
    init(frame : CGRect,childVcs : [UIViewController],parentViewController : UIViewController){
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame : frame)
        
        // 设置UI
        
        setUpUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageContentView{
    func setUpUI() {
        // 将所有的子控制器添加到fu控制器
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
// 代理数据源方法
extension PageContentView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)

        
            // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[(indexPath as NSIndexPath).item]
       
            childVc.view.frame = cell.contentView.bounds
           
            cell.contentView.addSubview(childVc.view)
      
        
        return cell
    }
    
}

extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbodScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
        print("startOffset======= %f",startOffsetX)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress : CGFloat
        var sourceIndex : Int
        var targetIndex : Int
        if isForbodScrollDelegate {
            return
        }
        // 判断左划 还是右划
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
     
        if currentOffsetX > startOffsetX { // 左划
            progress = currentOffsetX / scrollViewW  - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // TODO  如果完全划过去  目标 = source  progress = 1
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
                
            }
            
        }else{  //右划
            
            progress = 1 - (currentOffsetX / scrollViewW  - floor(currentOffsetX / scrollViewW))
            
            sourceIndex = Int(currentOffsetX / scrollViewW) + 1
            targetIndex = sourceIndex - 1
            if startOffsetX - currentOffsetX == scrollViewW {
                progress  = 1
               // targetIndex = sourceIndex
            }
          
        }
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK : - 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(_ currentIndex: Int) {
        isForbodScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y : 0), animated: false)
    }
}





















