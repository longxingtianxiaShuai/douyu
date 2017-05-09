//
//  RecommendViewController.swift
//  YU
//
//  Created by 高帅 on 2017/4/22.
//  Copyright © 2017年 chindor. All rights reserved.
//

import UIKit
let itemMargin : CGFloat = 10
let headerViewH : CGFloat = 30
let kitemWidth : CGFloat = (kScreenW - 3.0 * itemMargin)/2.0
let kitemNormalHeight : CGFloat = kitemWidth * 3.0 / 4.0
let kitemPrettyHeight : CGFloat = kitemWidth * 4.0 / 3.0
let kHeaderViewID = "kHeaderViewID"
let kNormalCellID = "normalCellID"
let kPrettyCellID = "PrettyCellID"

class RecommendViewController: UIViewController {

    let recommentViewModel : ReCommentViewModel = ReCommentViewModel()
   
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerViewH)
       
       // layout.itemSize  = CGSize(width: kitemWidth, height: kitemNormalHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "HeradCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.register(UINib(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        return collectionView
        
    }()
    
    // MARK : - liftStyle
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        view.addSubview(collectionView)
        
        recommentViewModel.requestRecommentDate()   
    }


 

}

extension RecommendViewController : UICollectionViewDelegate{
   
    

}

extension RecommendViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        return headerView
    }
    
    
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size : CGSize
        if indexPath.section == 1{
            size = CGSize(width: kitemWidth, height: kitemPrettyHeight)
        }else{
            size = CGSize(width: kitemWidth, height: kitemNormalHeight)
        }
        
        return size
    }
}
