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
        minimumLineSpacing = 0
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
        let sectionCount = CGFloat(collectionView.numberOfSections)
        let verticalSpacings = collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + minimumLineSpacing * (sectionCount - 1)
        let height = (collectionView.bounds.height - verticalSpacings) / sectionCount
        itemSize = CGSize(width: width, height: height)
    }
}
