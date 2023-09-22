//
//  CalendarDayFlowLayout.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import UIKit

class CalendarDayFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let spacings = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * 6
        let width = (collectionView.bounds.width - spacings) / 7
        let height = 40 + minimumLineSpacing
        itemSize = CGSize(width: width, height: height)
    }
}
