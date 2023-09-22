//
//  Extension+UICollectionView.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func setup(_ nibName: String, _ flowLayout: UICollectionViewFlowLayout) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        self.collectionViewLayout = flowLayout
    }
}
