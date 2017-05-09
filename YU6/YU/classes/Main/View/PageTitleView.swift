//
//  PageTitleView.swift
//  YU
//
//  Created by GaoShuai on 17/3/27.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class{
    func pageTitleViewClick(_ pageTitleView : PageTitleView,selectedIndex index : Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
class PageTitleView: UIView {

    fileprivate var titles : [String]
    fileprivate var currentIndex = 0
    fileprivate lazy var  titleLabels :[UILabel] = [UILabel]()
    weak var delegate : PageTitleViewDelegate?
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.red
        return scrollLine
        
    }()
    
    init(frame : CGRect, titles :[String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{
    func setUpUI(){
        // 添加scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加labels
        setUpTitleLabels()
        
        // 设置滚动条
        setUpBottomLineAndScrollowLine()
        
        
            
        }
        
   fileprivate func setUpTitleLabels(){
            let labelW = kScreenW / CGFloat(titles.count)
            let labelH = bounds.height
            let labelY : CGFloat = 0.0
            for (index,title) in titles.enumerated() {
                let label = UILabel()
                label.text = title
                label.tag = index
                label.isUserInteractionEnabled = true
                label.textAlignment = .center
                label.sizeToFit()
                let labelX = CGFloat(index) * labelW
                label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
                scrollView.addSubview(label)
                titleLabels.append(label)
                // 添加手势
                let tap  = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
                label.addGestureRecognizer(tap)
        }
    }
    fileprivate func setUpBottomLineAndScrollowLine(){
        
        // 添加底部分割线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 1.0
        bottomLine.frame = CGRect(x: 0.0, y: bounds.height - lineH, width: bounds.width, height: lineH)
        addSubview(bottomLine)
        
        
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 设置滚动条
      
        scrollLine.backgroundColor = firstLabel.textColor
        scrollLine.frame = CGRect(x: 0.0, y: bounds.height - kScrollLineH, width: firstLabel.bounds.width, height: kScrollLineH)
        addSubview(scrollLine)
    }
    
}

// MARK : - label手势
extension PageTitleView{
    func titleLabelClick(_ tapGesture : UITapGestureRecognizer) {
        guard let currentLabel = tapGesture.view as? UILabel else {
            return
        }
        if currentLabel.tag == currentIndex {return}
        
        // 获取之前label
        let oldLabel = titleLabels[currentIndex]
        // 颜色切换
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 滚动条
        let scollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.5) { 
            self.scrollLine.frame.origin.x = scollLineX
        }
        
        delegate?.pageTitleViewClick(self, selectedIndex: currentIndex)
    }
}



// MARK : - 对外暴露的方法
extension PageTitleView{
    func pageTitleView(progress : CGFloat,sourceIndex : Int, targetIndex : Int) {
      // print("progress ===  ",progress,sourceIndex,targetIndex)
        // 取出sourceLabel / targetLabel
        let sourceLabel = self.titleLabels[sourceIndex]
        let targetLabel = self.titleLabels[targetIndex]
        
        // 字体颜色变化
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 滚动条位置变化
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        currentIndex = targetIndex

        
    }
}
