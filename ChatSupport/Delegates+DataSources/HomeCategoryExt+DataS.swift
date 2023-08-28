//
//  HomeCategoryExt+DataS.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

class HomeCategoryDataSource: NSObject, UICollectionViewDataSource {
    
    private let viewModel: HomeCategoryVM!
    
    init(viewModel: HomeCategoryVM) { self.viewModel = viewModel }
    
    //MARK: UICollectionView DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrHomeCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as CategoryCVC
        let detail = viewModel.arrHomeCategory[indexPath.item]
        cell.lblTitle.text = detail.title
        cell.imgVwChat.image = detail.image
        cell.lblDescript.text = detail.descript
        return cell
    }
    
}

class HomeCategoryDelegates: NSObject, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private let objViewModel: HomeCategoryVM!
    var callbackDidSelect:((_ getIndex:Int)->())?
    
    init(viewModel: HomeCategoryVM) { objViewModel = viewModel }
    
    // MARK: UICollectionView Delegate Method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.size.width / 2) - 7.5)
        return CGSize(width: width, height: width + 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callbackDidSelect?(indexPath.item)
    }
}
