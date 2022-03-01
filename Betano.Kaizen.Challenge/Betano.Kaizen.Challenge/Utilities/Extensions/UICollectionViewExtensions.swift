//
//  UICollectionViewExtensions.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import UIKit

extension UICollectionView {
    func registerNoNibCell<T: UICollectionViewCell>(_ type: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.typeName)
    }
}
