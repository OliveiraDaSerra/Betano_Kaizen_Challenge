//
//  ListType.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import UIKit

enum ListType {
    case horizontalList

    var cvFlowLayout: UICollectionViewFlowLayout {
        return createCollectionViewLayout(sectionInset: sectioninset,
                                          itemSize: itemSize,
                                          minimumInteritemSpacing: minimumInteritemSpacing,
                                          minimumLineSpacing: minimumLineSpacing,
                                          scrollDirection: scrollDirection)
    }

    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    private var sectioninset: UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    }

    private var minimumInteritemSpacing: CGFloat {
        switch self {
        case .horizontalList:
            return 8.0
        }
    }

    private var minimumLineSpacing: CGFloat {
        switch self {
        case .horizontalList:
            return 8.0
        }
    }

    private var itemSize: CGSize {
        switch self {
        case .horizontalList:
            let offset = sectioninset.left + sectioninset.right + minimumInteritemSpacing
            return CGSize(width: (screenWidth - offset) / 3.0,
                          height: 140.0)
        }
    }

    private var scrollDirection: UICollectionView.ScrollDirection {
        return .horizontal
    }

    private func createCollectionViewLayout(sectionInset: UIEdgeInsets = .zero,
                                            itemSize: CGSize = .zero,
                                            minimumInteritemSpacing: CGFloat = 0.0,
                                            minimumLineSpacing: CGFloat = 0.0,
                                            scrollDirection: UICollectionView.ScrollDirection = .vertical) -> UICollectionViewFlowLayout {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset = sectionInset
        collectionFlowLayout.itemSize = itemSize
        collectionFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        collectionFlowLayout.minimumLineSpacing = minimumLineSpacing
        collectionFlowLayout.scrollDirection = scrollDirection
        return collectionFlowLayout
    }
}
